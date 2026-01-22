import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/user_model.dart';
import '../../storage/storage_keys.dart';
import '../../storage/storage_service.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.initial()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final storage = await StorageService.getInstance();
    final token = await storage.getSecureString(StorageKeys.accessToken);
    final userJson = storage.getJson(StorageKeys.userProfile);

    if (token != null && userJson != null) {
      // TODO: Validate token with backend
      await Future.delayed(const Duration(milliseconds: 500));

      try {
        final user = UserModel.fromJson(userJson);
        state = AuthState.authenticated(user);
      } catch (e) {
        state = const AuthState.unauthenticated();
      }
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock login validation
      if (email.isEmpty || password.isEmpty) {
        state = const AuthState.error('E-posta ve şifre gereklidir');
        return;
      }

      // Mock user based on email
      UserRole role = UserRole.customer;
      if (email.contains('employee')) {
        role = UserRole.employee;
      } else if (email.contains('business')) {
        role = UserRole.business;
      } else if (email.contains('admin')) {
        role = UserRole.admin;
      }

      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: email.split('@')[0].toUpperCase(),
        phone: '+90 555 123 4567',
        role: role,
        photoUrl: 'https://ui-avatars.com/api/?name=${email.split('@')[0]}',
        createdAt: DateTime.now(),
      );

      // Save to local storage
      final storage = await StorageService.getInstance();

      // Use Secure Storage for sensitive data
      await storage.setSecureString(
          StorageKeys.accessToken, 'mock_token_${user.id}');
      await storage.setSecureString(StorageKeys.userId, user.id);

      // Use Normal Storage for non-sensitive data
      await storage.setJson(StorageKeys.userProfile, user.toJson());
      await storage.setBool(StorageKeys.isLoggedIn, true);
      await storage.setString(StorageKeys.userRole, user.role.name);

      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    state = const AuthState.loading();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: name,
        phone: phone,
        role: UserRole.customer,
        photoUrl: 'https://ui-avatars.com/api/?name=$name',
        createdAt: DateTime.now(),
      );

      // Save to local storage
      final storage = await StorageService.getInstance();

      // Use Secure Storage
      await storage.setSecureString(
          StorageKeys.accessToken, 'mock_token_${user.id}');
      await storage.setSecureString(StorageKeys.userId, user.id);

      // Use Normal Storage
      await storage.setJson(StorageKeys.userProfile, user.toJson());
      await storage.setBool(StorageKeys.isLoggedIn, true);
      await storage.setString(StorageKeys.userRole, user.role.name);

      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> logout() async {
    state = const AuthState.loading();

    try {
      // Clear local storage
      final storage = await StorageService.getInstance();

      // Clear both normal and secure storage
      await storage.clear(); // SharedPreferences
      await storage.clearSecure(); // SecureStorage

      await Future.delayed(const Duration(milliseconds: 300));
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  void clearError() {
    state = const AuthState.unauthenticated();
  }
}
