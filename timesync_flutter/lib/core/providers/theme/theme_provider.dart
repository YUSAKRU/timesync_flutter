import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Theme Modes
enum AppThemeMode {
  light,
  dark,
  system,
}

extension AppThemeModeExtension on AppThemeMode {
  String get value {
    switch (this) {
      case AppThemeMode.light:
        return 'light';
      case AppThemeMode.dark:
        return 'dark';
      case AppThemeMode.system:
        return 'system';
    }
  }

  static AppThemeMode fromValue(String value) {
    switch (value) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      default:
        return AppThemeMode.system;
    }
  }
}

/// Theme Notifier - manages theme state
class ThemeNotifier extends StateNotifier<AppThemeMode> {
  final SharedPreferences prefs;
  static const String _themeKey = 'app_theme';

  ThemeNotifier(this.prefs)
      : super(
          AppThemeModeExtension.fromValue(
            prefs.getString(_themeKey) ?? 'system',
          ),
        );

  /// Toggle theme
  Future<void> toggleTheme() async {
    final newTheme = state == AppThemeMode.dark ? AppThemeMode.light : AppThemeMode.dark;
    await setTheme(newTheme);
  }

  /// Set specific theme
  Future<void> setTheme(AppThemeMode theme) async {
    state = theme;
    await prefs.setString(_themeKey, theme.value);
  }

  /// Get current theme
  AppThemeMode getCurrentTheme() => state;

  /// Check if dark mode
  bool isDarkMode() => state == AppThemeMode.dark;
}

/// Theme Provider
final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>((ref) {
  // Mock shared preferences - in production, inject from main.dart
  // For now, return dark mode as default
  return ThemeNotifier(
    _MockSharedPreferences(),
  );
});

/// Helper provider to check if dark mode
final isDarkModeProvider = Provider<bool>((ref) {
  return ref.watch(themeProvider) == AppThemeMode.dark;
});

/// Helper provider to toggle theme
final toggleThemeProvider = FutureProvider<void>((ref) async {
  final notifier = ref.read(themeProvider.notifier);
  await notifier.toggleTheme();
});

/// Mock SharedPreferences for development
class _MockSharedPreferences implements SharedPreferences {
  final Map<String, dynamic> _data = {};

  @override
  dynamic getSync(String key) => _data[key];

  @override
  bool? getBool(String key) => _data[key] as bool?;

  @override
  double? getDouble(String key) => _data[key] as double?;

  @override
  int? getInt(String key) => _data[key] as int?;

  @override
  List<String>? getStringList(String key) =>
      (_data[key] as List<dynamic>?)?.cast<String>();

  @override
  String? getString(String key) => _data[key] as String?;

  @override
  Set<String> getKeys() => _data.keys.toSet();

  @override
  bool containsKey(String key) => _data.containsKey(key);

  @override
  Future<bool> setBool(String key, bool value) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool> setString(String key, String value) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool> remove(String key) async {
    _data.remove(key);
    return true;
  }

  @override
  Future<bool> clear() async {
    _data.clear();
    return true;
  }

  @override
  Future<void> reload() async {}

  @override
  Object? get(String key) => _data[key];

  @override
  Future<bool> commit() async => true;
}
