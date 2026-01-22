import 'package:flutter/material.dart';

/// TimeSync Ana Renk Paleti
/// HTML/CSS tasarımlarından Flutter'a çevrilmiştir
class AppColors {
  AppColors._(); // Private constructor
  
  // Primary Colors - Ana yeşil ton
  static const Color primary = Color(0xFF36E27B);
  static const Color primaryDark = Color(0xFF2AB561);
  static const Color primaryLight = Color(0xFF5EF59D);
  
  // Background Colors
  static const Color backgroundLight = Color(0xFFF6F8F7);
  static const Color backgroundDark = Color(0xFF112117);
  static const Color darkBackground = Color(0xFF112117); // Alias for button text
  
  // Surface Colors - Kart ve panel arka planları
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1B3224);
  
  // Accent Colors - Vurgu renkleri
  static const Color accentPurple = Color(0xFFBA68C8);
  static const Color accentOrange = Color(0xFFFF8A65);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF95C6A9);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF000000);
  
  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, accentPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient darkGradient = LinearGradient(
    colors: [backgroundDark, surfaceDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
