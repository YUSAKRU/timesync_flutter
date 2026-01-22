import 'dart:math';
import '../../models/user_model.dart';
import '../result.dart';

/// Mock User Repository
/// Simulates API calls for user authentication and management
class MockUserRepository {
  final _random = Random();

  // Simulate network delay
  Future<void> _delay() async {
    await Future.delayed(Duration(milliseconds: 300 + _random.nextInt(700)));
  }

  /// Login with email and password
  Future<Result<UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      await _delay();

      // Find user by email
      final user = _mockUsers.firstWhere(
        (u) => u.email == email,
        orElse: () => throw Exception('Kullanıcı bulunamadı'),
      );

      // Simulate password check (in real app, this is done on backend)
      if (password.length < 6) {
        throw Exception('Şifre hatalı');
      }

      return Result.success(user);
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
      await _delay();

      // Check if email already exists
      final exists = _mockUsers.any((u) => u.email == email);
      if (exists) {
        throw Exception('Bu e-posta adresi zaten kayıtlı');
      }

      final newUser = UserModel(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: name,
        phone: phone,
        role: role,
        createdAt: DateTime.now(),
      );

      return Result.success(newUser);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get user by ID
  Future<Result<UserModel>> getUserById(String id) async {
    try {
      await _delay();

      final user = _mockUsers.firstWhere(
        (u) => u.id == id,
        orElse: () => throw Exception('Kullanıcı bulunamadı'),
      );

      return Result.success(user);
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
      await _delay();

      final user = _mockUsers.firstWhere(
        (u) => u.id == userId,
        orElse: () => throw Exception('Kullanıcı bulunamadı'),
      );

      final updatedUser = user.copyWith(
        name: name ?? user.name,
        phone: phone ?? user.phone,
        photoUrl: photoUrl ?? user.photoUrl,
      );

      return Result.success(updatedUser);
    } catch (e) {
      return Result.failure('Profil güncellenemedi: ${e.toString()}');
    }
  }

  /// Change password
  Future<Result<bool>> changePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await _delay();

      // Validate old password (mock check)
      if (oldPassword.length < 6) {
        throw Exception('Mevcut şifre hatalı');
      }

      // Validate new password
      if (newPassword.length < 6) {
        throw Exception('Yeni şifre en az 6 karakter olmalıdır');
      }

      return Result.success(true);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Logout
  Future<Result<bool>> logout() async {
    try {
      await _delay();
      return Result.success(true);
    } catch (e) {
      return Result.failure('Çıkış yapılamadı: ${e.toString()}');
    }
  }

  /// Reset password
  Future<Result<bool>> resetPassword({required String email}) async {
    try {
      await _delay();

      final exists = _mockUsers.any((u) => u.email == email);
      if (!exists) {
        throw Exception('Bu e-posta adresi kayıtlı değil');
      }

      return Result.success(true);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  // Mock users
  final List<UserModel> _mockUsers = [
    UserModel(
      id: 'user1',
      email: 'ahmet@example.com',
      name: 'Ahmet Yılmaz',
      phone: '+90 532 555 01 01',
      role: UserRole.customer,
      photoUrl: 'https://i.pravatar.cc/150?img=11',
      createdAt: DateTime.now().subtract(const Duration(days: 180)),
    ),
    UserModel(
      id: 'user2',
      email: 'mehmet@example.com',
      name: 'Mehmet Kaya',
      phone: '+90 532 555 02 02',
      role: UserRole.customer,
      photoUrl: 'https://i.pravatar.cc/150?img=12',
      createdAt: DateTime.now().subtract(const Duration(days: 150)),
    ),
    UserModel(
      id: 'user3',
      email: 'fatma@example.com',
      name: 'Fatma Şahin',
      phone: '+90 532 555 03 03',
      role: UserRole.customer,
      photoUrl: 'https://i.pravatar.cc/150?img=5',
      createdAt: DateTime.now().subtract(const Duration(days: 120)),
    ),
    UserModel(
      id: 'emp1',
      email: 'mehmet.usta@elite.com',
      name: 'Mehmet Usta',
      phone: '+90 532 555 10 01',
      role: UserRole.employee,
      photoUrl: 'https://i.pravatar.cc/150?img=13',
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
    ),
    UserModel(
      id: 'emp2',
      email: 'zeynep@guzellik.com',
      name: 'Zeynep Hanım',
      phone: '+90 532 555 10 02',
      role: UserRole.employee,
      photoUrl: 'https://i.pravatar.cc/150?img=9',
      createdAt: DateTime.now().subtract(const Duration(days: 300)),
    ),
    UserModel(
      id: 'biz1',
      email: 'admin@elite.com',
      name: 'Elite Yönetim',
      phone: '+90 216 555 01 01',
      role: UserRole.business,
      createdAt: DateTime.now().subtract(const Duration(days: 500)),
    ),
    UserModel(
      id: 'admin1',
      email: 'admin@timesync.com',
      name: 'Süper Admin',
      phone: '+90 212 555 00 00',
      role: UserRole.admin,
      createdAt: DateTime.now().subtract(const Duration(days: 730)),
    ),
  ];
}
