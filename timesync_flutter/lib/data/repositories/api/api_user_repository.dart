import 'package:dio/dio.dart';

import '../../../core/network/api_config.dart';
import '../../../core/storage/cache_manager.dart';
import '../../../core/storage/storage_keys.dart';
import '../../../core/storage/storage_service.dart';
import '../../models/user_model.dart';
import '../../network/api_client.dart';
import '../result.dart';

/// API User/Auth Repository
/// Handles authentication and user-related API calls
class ApiUserRepository {
  final ApiClient _apiClient = ApiClient.instance;
  final CacheManager? _cacheManager;

  ApiUserRepository({CacheManager? cacheManager})
      : _cacheManager = cacheManager;

  /// Login with email and password
  Future<Result<UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConfig.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;

        // Save tokens
        final accessToken = data['access_token'] ?? data['token'];
        final refreshToken = data['refresh_token'];

        if (accessToken != null) {
          await _saveTokens(accessToken, refreshToken);
        }

        // Parse user
        final user = UserModel.fromJson(data['user'] ?? data);

        // Save user info
        await _saveUserInfo(user);

        return Result.success(user);
      } else {
        return Result.failure('Giriş başarısız');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Giriş yapılamadı');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Register new user
  Future<Result<UserModel>> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    UserRole role = UserRole.customer,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConfig.register,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
          'role': role.name,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;

        // Save tokens
        final accessToken = data['access_token'] ?? data['token'];
        final refreshToken = data['refresh_token'];

        if (accessToken != null) {
          await _saveTokens(accessToken, refreshToken);
        }

        // Parse user
        final user = UserModel.fromJson(data['user'] ?? data);

        // Save user info
        await _saveUserInfo(user);

        return Result.success(user);
      } else {
        return Result.failure('Kayıt başarısız');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Kayıt olunamadı');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Logout
  Future<Result<bool>> logout() async {
    try {
      await _apiClient.post(ApiConfig.logout);
      await _clearLocalData();
      return Result.success(true);
    } on DioException catch (e) {
      // Clear local data even if API call fails
      await _clearLocalData();
      return Result.failure(e.error?.toString() ?? 'Çıkış yapılamadı');
    } catch (e) {
      await _clearLocalData();
      return Result.failure(e.toString());
    }
  }

  /// Get current user profile
  Future<Result<UserModel>> getProfile() async {
    try {
      final response = await _apiClient.get(ApiConfig.profile);

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(
          response.data['data'] ?? response.data,
        );

        // Cache the user profile
        if (_cacheManager != null) {
          await _cacheManager!.cacheUserProfile(user);
        }

        await _saveUserInfo(user);
        return Result.success(user);
      } else {
        // Fallback to cache on error
        if (_cacheManager != null) {
          final cached = _cacheManager!.getCachedUserProfile();
          if (cached != null) return Result.success(cached);
        }
        return Result.failure('Profil yüklenemedi');
      }
    } on DioException catch (e) {
      // Offline fallback
      if (_cacheManager != null) {
        final cached = _cacheManager!.getCachedUserProfile();
        if (cached != null) return Result.success(cached);
      }
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get user by ID
  Future<Result<UserModel>> getUserById(String id) async {
    try {
      final response = await _apiClient.get('${ApiConfig.users}/$id');

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(user);
      } else {
        return Result.failure('Kullanıcı bulunamadı');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Update user profile
  Future<Result<UserModel>> updateProfile({
    required String userId,
    String? name,
    String? phone,
    String? photoUrl,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (phone != null) data['phone'] = phone;
      if (photoUrl != null) data['photoUrl'] = photoUrl;

      final response = await _apiClient.put(
        '${ApiConfig.users}/$userId',
        data: data,
      );

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(
          response.data['data'] ?? response.data,
        );
        await _saveUserInfo(user);
        return Result.success(user);
      } else {
        return Result.failure('Profil güncellenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Change password
  Future<Result<bool>> changePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _apiClient.put(
        '${ApiConfig.users}/$userId/password',
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );

      if (response.statusCode == 200) {
        return Result.success(true);
      } else {
        return Result.failure('Şifre değiştirilemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Reset password
  Future<Result<bool>> resetPassword({required String email}) async {
    try {
      final response = await _apiClient.post(
        '${ApiConfig.auth}/reset-password',
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        return Result.success(true);
      } else {
        return Result.failure('Şifre sıfırlama isteği gönderilemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  // Helper methods
  Future<void> _saveTokens(String accessToken, String? refreshToken) async {
    final storage = await StorageService.getInstance();
    await storage.setSecureString(StorageKeys.accessToken, accessToken);
    if (refreshToken != null) {
      await storage.setSecureString(StorageKeys.refreshToken, refreshToken);
    }
  }

  Future<void> _saveUserInfo(UserModel user) async {
    final storage = await StorageService.getInstance();
    await storage.setSecureString(StorageKeys.userId, user.id);
    await storage.setJson(StorageKeys.userProfile, user.toJson());
    await storage.setString(StorageKeys.userRole, user.role.name);
    await storage.setBool(StorageKeys.isLoggedIn, true);

    // Also update cache if available
    if (_cacheManager != null) {
      await _cacheManager!.cacheUserProfile(user);
    }
  }

  Future<void> _clearLocalData() async {
    final storage = await StorageService.getInstance();
    await storage.clearSecure(); // Clear encrypted tokens
    await storage.clear(); // Clear normal preferences
  }
}
