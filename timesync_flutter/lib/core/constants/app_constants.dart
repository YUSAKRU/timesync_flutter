/// TimeSync Sabitler
class AppConstants {
  AppConstants._();
  
  // App Info
  static const String appName = 'TimeSync';
  static const String appTagline = 'Zamanın Senin Kontrolünde';
  static const String appVersion = '1.0.0';
  
  // API (şu an mock, sonra gerçek API)
  static const String apiBaseUrl = 'https://api.timesync.com/v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Padding & Spacing
  static const double paddingXS = 4.0;
  static const double paddingSM = 8.0;
  static const double paddingMD = 16.0;
  static const double paddingLG = 24.0;
  static const double paddingXL = 32.0;
  
  // Border Radius
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusFull = 9999.0;
  
  // Icon Sizes
  static const double iconSM = 16.0;
  static const double iconMD = 24.0;
  static const double iconLG = 32.0;
  static const double iconXL = 48.0;
  
  // Max Width (mobile-first)
  static const double maxMobileWidth = 480.0;
  
  // Splash Screen
  static const Duration splashDuration = Duration(seconds: 3);
}
