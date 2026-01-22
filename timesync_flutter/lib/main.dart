import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_theme.dart';
import 'core/services/notification_service.dart';
import 'core/providers/theme/theme_provider.dart';
import 'presentation/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  try {
    await Firebase.initializeApp();
    print('✅ Firebase initialized');
  } catch (e) {
    print('⚠️ Firebase initialization warning: $e');
  }
  
  // Initialize Notification Service
  await NotificationService.instance.initialize();
  
  // Initialize date formatting for Turkish locale
  await initializeDateFormatting('tr_TR', null);
  
  runApp(
    const ProviderScope(
      child: TimeSyncApp(),
    ),
  );
}

class TimeSyncApp extends ConsumerWidget {
  const TimeSyncApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    
    return MaterialApp(
      title: 'TimeSync',
      debugShowCheckedModeBanner: false,
      
      // Tema
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeModeToFlutterThemeMode(themeMode),
      
      // Ana sayfa
      home: const SplashScreen(),
      
      // TODO: Routing eklenecek
      // routes: {
      //   '/welcome': (context) => const WelcomeScreen(),
      //   '/login': (context) => const LoginScreen(),
      // },
    );
  }
}

/// Convert app AppThemeMode to Flutter ThemeMode
ThemeMode _themeModeToFlutterThemeMode(AppThemeMode themeMode) {
  switch (themeMode) {
    case AppThemeMode.light:
      return ThemeMode.light;
    case AppThemeMode.dark:
      return ThemeMode.dark;
    case AppThemeMode.system:
      return ThemeMode.system;
  }
}
