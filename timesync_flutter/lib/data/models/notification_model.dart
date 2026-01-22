import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

/// Notification Types
enum NotificationType {
  appointmentConfirmed,    // Randevu onaylandı
  appointmentReminder,     // Randevu hatırlatması (24 saat, 1 saat, 30 dk)
  appointmentCancelled,    // Randevu iptal edildi
  appointmentRescheduled,  // Randevu rescheduled
  newReview,               // Yeni review/rating
  businessUpdate,          // İşletme update'i
  systemNotification,      // Sistem bildirimi
}

extension NotificationTypeExtension on NotificationType {
  String get value {
    return toString().split('.').last;
  }

  String get titleTr {
    switch (this) {
      case NotificationType.appointmentConfirmed:
        return 'Randevu Onaylandı';
      case NotificationType.appointmentReminder:
        return 'Randevu Hatırlatması';
      case NotificationType.appointmentCancelled:
        return 'Randevu İptal Edildi';
      case NotificationType.appointmentRescheduled:
        return 'Randevu Rescheduled';
      case NotificationType.newReview:
        return 'Yeni Review';
      case NotificationType.businessUpdate:
        return 'İşletme Güncelleme';
      case NotificationType.systemNotification:
        return 'Sistem Bildirimi';
    }
  }
}

/// Notification Model
@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String userId,
    required NotificationType type,
    required String title,
    required String body,
    String? imageUrl,
    
    // Metadata
    Map<String, dynamic>? metadata,
    String? appointmentId,
    String? businessId,
    String? reviewId,
    
    // Status
    required bool isRead,
    required DateTime createdAt,
    DateTime? readAt,
    
    // Action
    String? deeplink,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}

/// Push Notification Payload (from FCM)
@freezed
class PushNotificationPayload with _$PushNotificationPayload {
  const factory PushNotificationPayload({
    required String title,
    required String body,
    String? imageUrl,
    Map<String, String>? data,
  }) = _PushNotificationPayload;

  factory PushNotificationPayload.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationPayloadFromJson(json);
}

/// Notification Response (from Repository)
@freezed
class NotificationResponse with _$NotificationResponse {
  const factory NotificationResponse({
    required List<NotificationModel> notifications,
    required int unreadCount,
    required bool hasMore,
  }) = _NotificationResponse;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);
}
