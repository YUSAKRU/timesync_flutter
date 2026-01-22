import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesync_flutter/data/models/notification_model.dart';
import 'package:timesync_flutter/data/repositories/api/api_notification_repository.dart';

// Notification Repository Provider
final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  // Development: Use MockNotificationRepository
  // Production: Use ApiNotificationRepository with Dio
  return MockNotificationRepository();
  // return ApiNotificationRepository(dio: ref.watch(dioProvider));
});

// Notifications List State
final notificationsProvider = FutureProvider.family<
    NotificationResponse,
    ({int page, int limit})>((ref, params) async {
  final repository = ref.watch(notificationRepositoryProvider);
  final authState = ref.watch(authProvider); // Assuming authProvider exists

  // Get user ID from auth state
  final userId = 'user_1'; // TODO: Replace with actual user ID from auth

  return repository.getUserNotifications(
    userId: userId,
    page: params.page,
    limit: params.limit,
  );
});

// Unread Count Provider
final unreadNotificationCountProvider = FutureProvider<int>((ref) async {
  final response = await ref.watch(notificationsProvider(
    (page: 1, limit: 20),
  ).future);
  return response.unreadCount;
});

// Mark Notification as Read
final markNotificationAsReadProvider =
    FutureProvider.family<void, String>((ref, id) async {
  final repository = ref.watch(notificationRepositoryProvider);
  await repository.markNotificationAsRead(id);
  // Invalidate notifications cache
  ref.invalidate(notificationsProvider);
});

// Mark All as Read
final markAllNotificationsAsReadProvider = FutureProvider<void>((ref) async {
  final repository = ref.watch(notificationRepositoryProvider);
  await repository.markAllNotificationsAsRead();
  // Invalidate notifications cache
  ref.invalidate(notificationsProvider);
});

// Delete Notification
final deleteNotificationProvider =
    FutureProvider.family<void, String>((ref, id) async {
  final repository = ref.watch(notificationRepositoryProvider);
  await repository.deleteNotification(id);
  // Invalidate notifications cache
  ref.invalidate(notificationsProvider);
});

// Register FCM Token
final registerFcmTokenProvider = FutureProvider.family<
    void,
    ({
      String userId,
      String token,
      String deviceType,
    })>((ref, params) async {
  final repository = ref.watch(notificationRepositoryProvider);
  await repository.registerFcmToken(
    userId: params.userId,
    token: params.token,
    deviceType: params.deviceType,
  );
});

// Unregister FCM Token
final unregisterFcmTokenProvider = FutureProvider.family<
    void,
    ({
      String userId,
      String token,
    })>((ref, params) async {
  final repository = ref.watch(notificationRepositoryProvider);
  await repository.unregisterFcmToken(
    userId: params.userId,
    token: params.token,
  );
});

// Notification Badge Count (for app icon badge)
final notificationBadgeCountProvider = StateProvider<int>((ref) {
  // This will be updated by listening to FCM messages
  return 0;
});

// Add this for the auth provider import resolution
final authProvider = StateProvider<AuthState>((ref) {
  return const AuthState.unauthenticated();
});

/// Auth State (minimal for this example)
class AuthState {
  final String? userId;
  final bool isAuthenticated;

  const AuthState({
    this.userId,
    this.isAuthenticated = false,
  });

  const AuthState.unauthenticated()
      : userId = null,
        isAuthenticated = false;

  const AuthState.authenticated({required String userId})
      : userId = userId,
        isAuthenticated = true;
}
