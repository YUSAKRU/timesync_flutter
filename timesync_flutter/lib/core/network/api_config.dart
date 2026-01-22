import 'package:flutter/foundation.dart';

import '../config/env.dart';

/// API Configuration Constants
class ApiConfig {
  // Base URLs
  static String get baseUrl {
    if (kReleaseMode) {
      return EnvProd.apiBaseUrl;
    }
    return EnvDev.apiBaseUrl;
  }

  // Use environment specific URL
  static String get currentBaseUrl => baseUrl;

  // Timeout durations
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // API Endpoints
  static const String auth = '/auth';
  static const String login = '$auth/login';
  static const String register = '$auth/register';
  static const String logout = '$auth/logout';
  static const String refreshToken = '$auth/refresh';

  static const String users = '/users';
  static const String profile = '$users/profile';

  static const String businesses = '/businesses';
  static const String businessById = '$businesses/{id}';
  static const String businessSearch = '$businesses/search';
  static const String featuredBusinesses = '$businesses/featured';

  static const String services = '/services';
  static const String servicesByBusiness = '$services/business/{businessId}';

  static const String employees = '/employees';
  static const String employeesByBusiness = '$employees/business/{businessId}';
  static const String topEmployees = '$employees/top';

  static const String appointments = '/appointments';
  static const String appointmentById = '$appointments/{id}';
  static const String userAppointments = '$appointments/user/{userId}';
  static const String businessAppointments =
      '$appointments/business/{businessId}';
  static const String createAppointment = appointments;
  static const String cancelAppointment = '$appointments/{id}/cancel';

  static const String reviews = '/reviews';
  static const String reviewsByBusiness = '$reviews/business/{businessId}';
  static const String createReview = reviews;
  static const String addReviewResponse = '$reviews/{id}/response';
  static const String reviewStats = '$reviews/business/{businessId}/stats';
  static const String reviewById = '$reviews/{id}';
  static const String deleteReview = '$reviews/{id}';
  static const String helpfulReview = '$reviews/{id}/helpful';
  static const String unhelpfulReview = '$reviews/{id}/unhelpful';
  static const String reportReview = '$reviews/{id}/report';

  static const String timeSlots = '/time-slots';
  static const String availableSlots = '$timeSlots/available';

  // Notifications
  static const String notifications = '/notifications';
  static const String userNotifications = '$notifications/user/{userId}';
  static const String notificationById = '$notifications/{id}';
  static const String markAsRead = '$notifications/{id}/read';
  static const String markAllAsRead = '$notifications/mark-all-read';
  static const String deleteNotification = '$notifications/{id}';
  static const String fcmTokenRegister = '$notifications/fcm-token/register';
  static const String fcmTokenUnregister =
      '$notifications/fcm-token/unregister';

  // Header keys
  static const String authorizationHeader = 'Authorization';
  static const String contentTypeHeader = 'Content-Type';
  static const String acceptHeader = 'Accept';

  // Header values
  static const String bearerPrefix = 'Bearer';
  static const String jsonContentType = 'application/json';

  // Storage keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String userRoleKey = 'user_role';

  // Backwards compatibility or alternative name
  static const String businessServices = servicesByBusiness;
  static const String businessEmployees = employeesByBusiness;
  static const String businessReviews = reviewsByBusiness;
}
