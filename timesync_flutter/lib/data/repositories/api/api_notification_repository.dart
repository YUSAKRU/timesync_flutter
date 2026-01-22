import 'package:dio/dio.dart';
import '../../../core/network/api_config.dart';
import '../../models/notification_model.dart';

abstract class NotificationRepository {
  Future<NotificationResponse> getUserNotifications({
    required String userId,
    int page = 1,
    int limit = 20,
  });

  Future<NotificationModel> getNotificationById(String id);

  Future<void> markNotificationAsRead(String id);

  Future<void> markAllNotificationsAsRead();

  Future<void> deleteNotification(String id);

  Future<void> registerFcmToken({
    required String userId,
    required String token,
    required String deviceType,
  });

  Future<void> unregisterFcmToken({
    required String userId,
    required String token,
  });
}

class ApiNotificationRepository implements NotificationRepository {
  final Dio dio;

  ApiNotificationRepository({required this.dio});

  @override
  Future<NotificationResponse> getUserNotifications({
    required String userId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await dio.get(
        ApiConfig.userNotifications.replaceFirst('{userId}', userId),
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      return NotificationResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<NotificationModel> getNotificationById(String id) async {
    try {
      final response = await dio.get(
        ApiConfig.notificationById.replaceFirst('{id}', id),
      );

      return NotificationModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> markNotificationAsRead(String id) async {
    try {
      await dio.patch(
        ApiConfig.markAsRead.replaceFirst('{id}', id),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> markAllNotificationsAsRead() async {
    try {
      await dio.patch(ApiConfig.markAllAsRead);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteNotification(String id) async {
    try {
      await dio.delete(
        ApiConfig.deleteNotification.replaceFirst('{id}', id),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> registerFcmToken({
    required String userId,
    required String token,
    required String deviceType,
  }) async {
    try {
      await dio.post(
        ApiConfig.fcmTokenRegister,
        data: {
          'userId': userId,
          'token': token,
          'deviceType': deviceType,
          'platform': 'flutter',
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> unregisterFcmToken({
    required String userId,
    required String token,
  }) async {
    try {
      await dio.post(
        ApiConfig.fcmTokenUnregister,
        data: {
          'userId': userId,
          'token': token,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}

/// Mock Notification Repository for Development
class MockNotificationRepository implements NotificationRepository {
  @override
  Future<NotificationResponse> getUserNotifications({
    required String userId,
    int page = 1,
    int limit = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final mockNotifications = List.generate(
      limit,
      (i) => NotificationModel(
        id: 'notif_$i',
        userId: userId,
        type: NotificationType.values[i % NotificationType.values.length],
        title: 'Bildirim ${i + 1}',
        body: 'Bu, örnek bir bildirimdir. Gerçek bildirimleri görmek için sistemi bağlayın.',
        isRead: i > 5,
        createdAt: DateTime.now().subtract(Duration(hours: i)),
        appointmentId: i % 3 == 0 ? 'appt_${i}' : null,
      ),
    );

    return NotificationResponse(
      notifications: mockNotifications,
      unreadCount: 3,
      hasMore: page < 5,
    );
  }

  @override
  Future<NotificationModel> getNotificationById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return NotificationModel(
      id: id,
      userId: 'user_1',
      type: NotificationType.appointmentReminder,
      title: 'Randevu Hatırlatması',
      body: 'Yarın saat 14:00\'de Dr. Ayşe ile randevunuz var.',
      isRead: false,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<void> markNotificationAsRead(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> markAllNotificationsAsRead() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> deleteNotification(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> registerFcmToken({
    required String userId,
    required String token,
    required String deviceType,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    print('Mock FCM Token Registered: $token for user $userId');
  }

  @override
  Future<void> unregisterFcmToken({
    required String userId,
    required String token,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    print('Mock FCM Token Unregistered: $token for user $userId');
  }
}
