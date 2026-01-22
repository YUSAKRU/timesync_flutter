/// API endpoint yapılandırması
class ApiConfig {
  // Base URL
  static const String baseUrl = 'https://api.timesync.com/v1';

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String verifyEmail = '/auth/verify-email';
  static const String resetPassword = '/auth/reset-password';

  // User endpoints
  static const String userProfile = '/users/profile';
  static const String updateProfile = '/users/profile';
  static const String changePassword = '/users/change-password';

  // Business endpoints
  static const String businesses = '/businesses';
  static const String businessById = '/businesses/{id}';
  static const String featuredBusinesses = '/businesses/featured';
  static const String businessSearch = '/businesses/search';
  static const String businessServices = '/businesses/{businessId}/services';

  // Service endpoints
  static const String services = '/services';
  static const String serviceById = '/services/{id}';

  // Appointment endpoints
  static const String appointments = '/appointments';
  static const String appointmentById = '/appointments/{id}';
  static const String userAppointments = '/users/{userId}/appointments';
  static const String businessAppointments = '/businesses/{businessId}/appointments';
  static const String cancelAppointment = '/appointments/{id}/cancel';

  // Time slots
  static const String timeSlots = '/time-slots';
  static const String availableTimeSlots = '/time-slots/available';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
}
