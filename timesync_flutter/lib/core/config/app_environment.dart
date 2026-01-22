/// Environment configuration
/// Toggle between mock and real API
class AppEnvironment {
  // Change this to false when connecting to real API
  static const bool useMockData = true;

  // API environment
  static const bool useDevApi = true; // true for dev, false for production

  // Feature flags
  static const bool enableLogging = true;
  static const bool enableAnalytics = false;

  // Timeouts (in seconds)
  static const int connectTimeout = 30;
  static const int receiveTimeout = 30;

  // Cache
  static const bool enableCache = true;
  static const int cacheDuration = 300; // 5 minutes
}
