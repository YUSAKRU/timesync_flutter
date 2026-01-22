// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      title: json['title'] as String,
      body: json['body'] as String,
      imageUrl: json['imageUrl'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      appointmentId: json['appointmentId'] as String?,
      businessId: json['businessId'] as String?,
      reviewId: json['reviewId'] as String?,
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      deeplink: json['deeplink'] as String?,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'title': instance.title,
      'body': instance.body,
      'imageUrl': instance.imageUrl,
      'metadata': instance.metadata,
      'appointmentId': instance.appointmentId,
      'businessId': instance.businessId,
      'reviewId': instance.reviewId,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt.toIso8601String(),
      'readAt': instance.readAt?.toIso8601String(),
      'deeplink': instance.deeplink,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.appointmentConfirmed: 'appointmentConfirmed',
  NotificationType.appointmentReminder: 'appointmentReminder',
  NotificationType.appointmentCancelled: 'appointmentCancelled',
  NotificationType.appointmentRescheduled: 'appointmentRescheduled',
  NotificationType.newReview: 'newReview',
  NotificationType.businessUpdate: 'businessUpdate',
  NotificationType.systemNotification: 'systemNotification',
};

_$PushNotificationPayloadImpl _$$PushNotificationPayloadImplFromJson(
        Map<String, dynamic> json) =>
    _$PushNotificationPayloadImpl(
      title: json['title'] as String,
      body: json['body'] as String,
      imageUrl: json['imageUrl'] as String?,
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$PushNotificationPayloadImplToJson(
        _$PushNotificationPayloadImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'imageUrl': instance.imageUrl,
      'data': instance.data,
    };

_$NotificationResponseImpl _$$NotificationResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationResponseImpl(
      notifications: (json['notifications'] as List<dynamic>)
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      unreadCount: (json['unreadCount'] as num).toInt(),
      hasMore: json['hasMore'] as bool,
    );

Map<String, dynamic> _$$NotificationResponseImplToJson(
        _$NotificationResponseImpl instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
      'unreadCount': instance.unreadCount,
      'hasMore': instance.hasMore,
    };
