import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../data/models/notification_model.dart' hide NotificationResponse;

/// Firebase Messaging Background Handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');

  // Local notification gönder
  await NotificationService.instance._showLocalNotification(
    title: message.notification?.title ?? 'Bildirim',
    body: message.notification?.body ?? '',
    payload: message.data,
  );
}

/// Notification Service - Firebase FCM + Local Notifications
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  static NotificationService get instance => _instance;

  NotificationService._internal();

  FirebaseMessaging? _firebaseMessaging;
  late final FlutterLocalNotificationsPlugin _localNotifications;

  // Streams
  final _notificationStream =
      StreamController<PushNotificationPayload>.broadcast();
  Stream<PushNotificationPayload> get notificationStream =>
      _notificationStream.stream;

  final _foregroundNotificationStream =
      StreamController<RemoteMessage>.broadcast();
  Stream<RemoteMessage> get foregroundNotificationStream =>
      _foregroundNotificationStream.stream;

  bool _isInitialized = false;

  /// Initialize Notification Service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Firebase Messaging Permissions
      try {
        _firebaseMessaging = FirebaseMessaging.instance;
        await _firebaseMessaging?.requestPermission(
          alert: true,
          announcement: true,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );

        // Setup background message handler
        FirebaseMessaging.onBackgroundMessage(
            _firebaseMessagingBackgroundHandler);

        // Setup message handlers
        _setupMessageHandlers();
      } catch (e) {
        print('⚠️ FCM initialization skipped: $e');
      }

      // iOS specific
      if (Platform.isIOS && _firebaseMessaging != null) {
        await _firebaseMessaging?.getAPNSToken();
      }

      // Setup local notifications
      _setupLocalNotifications();

      _isInitialized = true;
      print('✅ Notification Service initialized');
    } catch (e) {
      print('❌ Notification Service initialization failed: $e');
    }
  }

  /// Setup Local Notifications
  void _setupLocalNotifications() {
    _localNotifications = FlutterLocalNotificationsPlugin();

    // Android setup
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS setup
    final DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      notificationCategories: [
        DarwinNotificationCategory(
          'appointment',
          actions: [
            DarwinNotificationAction.plain('confirm', 'Onayla'),
            DarwinNotificationAction.plain('cancel', 'İptal'),
          ],
        ),
      ],
    );

    final initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _handleNotificationTap(response.payload ?? '');
      },
    );
  }

  /// Setup FCM Message Handlers
  void _setupMessageHandlers() {
    // Foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message received: ${message.notification?.title}');
      _foregroundNotificationStream.add(message);

      // Show local notification
      _showLocalNotification(
        title: message.notification?.title ?? 'Bildirim',
        body: message.notification?.body ?? '',
        payload: message.data,
      );
    });

    // Terminated message handler
    _firebaseMessaging?.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('App opened from terminated notification');
        _handleNotificationTap(message.data['deeplink'] ?? '');
      }
    });

    // Resume message handler
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened app: ${message.notification?.title}');
      _handleNotificationTap(message.data['deeplink'] ?? '');
    });
  }

  /// Show Local Notification
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    Map<String, dynamic>? payload,
  }) async {
    try {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'timesync_channel',
        'TimeSync Notifications',
        channelDescription: 'Randevu bildirimleri',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
        playSound: true,
        enableVibration: true,
      );

      const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _localNotifications.show(
        DateTime.now().millisecond,
        title,
        body,
        details,
        payload: payload?['deeplink'] ?? '',
      );
    } catch (e) {
      print('Error showing local notification: $e');
    }
  }

  /// Get FCM Token
  Future<String?> getFcmToken() async {
    try {
      if (_firebaseMessaging == null) return null;
      final token = await _firebaseMessaging?.getToken();
      print('FCM Token: $token');
      return token;
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }

  /// Subscribe to Topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging?.subscribeToTopic(topic);
      print('✅ Subscribed to topic: $topic');
    } catch (e) {
      print('❌ Error subscribing to topic: $e');
    }
  }

  /// Unsubscribe from Topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging?.unsubscribeFromTopic(topic);
      print('✅ Unsubscribed from topic: $topic');
    } catch (e) {
      print('❌ Error unsubscribing from topic: $e');
    }
  }

  /// Handle Notification Tap
  void _handleNotificationTap(String deeplink) {
    if (deeplink.isNotEmpty) {
      final payload = PushNotificationPayload(
        title: 'Tap Handled',
        body: deeplink,
      );
      _notificationStream.add(payload);
    }
  }

  /// Dispose
  void dispose() {
    _notificationStream.close();
    _foregroundNotificationStream.close();
  }
}
