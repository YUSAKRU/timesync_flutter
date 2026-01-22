# 🚀 Flutter Kurulum ve İlk Proje Rehberi

## 📥 Adım 1: Flutter SDK Kurulumu

### Flutter İndirmesi Devam Ediyor...
Terminal'de Flutter SDK indiriliyor. Tamamlandığında şu adımları izleyin:

### PATH Ayarlama
```bash
# .bashrc dosyanızı açın
nano ~/.bashrc

# En alta şunu ekleyin:
export PATH="$PATH:$HOME/flutter/bin"

# Kaydet ve çık (Ctrl+O, Enter, Ctrl+X)

# Değişiklikleri uygula
source ~/.bashrc

# Flutter'ı test et
flutter --version
```

---

## 🔧 Adım 2: Gerekli Araçları Kur

### Flutter Doctor
```bash
# Flutter kurulumunu kontrol et
flutter doctor

# Çıktı şuna benzeyecek:
# [✓] Flutter (Channel stable, 3.x.x, ...)
# [✗] Android toolchain - Android SDK eksik
# [✗] Chrome - Web development
# [✓] Linux toolchain
```

### Android Studio Kurulumu (Önerilen)
```bash
# Flatpak ile Android Studio kur
flatpak install flathub com.google.AndroidStudio

# Veya Snap ile:
sudo snap install android-studio --classic

# Android Studio'yu aç:
android-studio
```

#### Android Studio İlk Kurulum
1. Android Studio'yu açın
2. **Configure** → **SDK Manager**
3. **SDK Platforms** → Android 13.0 (Tiramisu) seçin
4. **SDK Tools** → Şunları seçin:
   - Android SDK Build-Tools
   - Android SDK Command-line Tools
   - Android SDK Platform-Tools
   - Android Emulator
5. **Apply** → İndir

### Android Licenses
```bash
flutter doctor --android-licenses
# Tüm lisansları kabul edin (y basın)
```

---

## 📱 Adım 3: Emulator Kurulumu

### Android Emulator Oluşturma
```bash
# Android Studio'da
# Tools → Device Manager → Create Device

# Önerilen:
# - Device: Pixel 6
# - System Image: Android 13.0 (API 33)
# - AVD Name: TimeSync_Test
```

### Emulator Başlatma
```bash
# Terminalde
flutter emulators

# Çıktı:
# TimeSync_Test • pixel_6 • Google • android

# Başlat
flutter emulators --launch TimeSync_Test
```

---

## 🆕 Adım 4: Flutter Projesi Oluşturma

### Proje Oluştur
```bash
cd ~/Documents/projects/sistem-analiz-ve-tasarımı/timeSync

# Flutter projesi oluştur
flutter create timesync_flutter \
  --org com.timesync \
  --description "Modern Randevu Yönetim Sistemi" \
  --platforms android,ios

cd timesync_flutter
```

### Proje Yapısını Kontrol Et
```bash
tree -L 2 -I 'build|.dart_tool'

# Çıktı:
# timesync_flutter/
# ├── android/          # Android native kod
# ├── ios/              # iOS native kod
# ├── lib/              # Dart kaynak kodları
# │   └── main.dart
# ├── test/             # Test dosyaları
# ├── pubspec.yaml      # Dependencies
# └── README.md
```

---

## 📦 Adım 5: Dependencies Ekleme

### pubspec.yaml Düzenle
```bash
code pubspec.yaml
```

```yaml
name: timesync_flutter
description: Modern Randevu Yönetim Sistemi
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # UI & Design
  google_fonts: ^6.1.0
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.0
  
  # Navigation
  go_router: ^13.0.0
  
  # State Management
  flutter_riverpod: ^2.4.9
  
  # Storage
  shared_preferences: ^2.2.2
  
  # Network
  dio: ^5.4.0
  
  # Utils
  intl: ^0.18.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
  
  # assets:
  #   - assets/images/
  #   - assets/icons/
  
  # fonts:
  #   - family: CustomFont
  #     fonts:
  #       - asset: assets/fonts/CustomFont.ttf
```

### Dependencies İndir
```bash
flutter pub get
```

---

## 🎨 Adım 6: İlk Tema Dosyasını Oluştur

### Klasör Yapısını Oluştur
```bash
mkdir -p lib/core/{constants,theme,router}
mkdir -p lib/presentation/{splash,welcome,auth}
mkdir -p lib/data/{models,repositories,services}
```

### Renk Paletini Oluştur
```bash
code lib/core/constants/app_colors.dart
```

```dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const primary = Color(0xFF36E27B);
  static const primaryDark = Color(0xFF2AB561);
  
  // Background
  static const backgroundLight = Color(0xFFF6F8F7);
  static const backgroundDark = Color(0xFF112117);
  
  // Surface
  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceDark = Color(0xFF1B3224);
  
  // Accent
  static const accentPurple = Color(0xFFBA68C8);
  static const accentOrange = Color(0xFFFF8A65);
  
  // Text
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF95C6A9);
}
```

### Ana Tema Oluştur
```bash
code lib/core/theme/app_theme.dart
```

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    
    textTheme: GoogleFonts.splineSansTextTheme(),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    ),
  );
  
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    
    textTheme: GoogleFonts.splineSansTextTheme(ThemeData.dark().textTheme),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    ),
  );
}
```

---

## 🏠 Adım 7: İlk Splash Screen

```bash
code lib/presentation/splash/splash_screen.dart
```

```dart
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    // Navigator.pushReplacementNamed(context, '/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo placeholder
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.schedule,
                size: 64,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'TimeSync',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Zamanın Senin Kontrolünde',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 🎯 Adım 8: main.dart Güncelle

```bash
code lib/main.dart
```

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'presentation/splash/splash_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TimeSyncApp(),
    ),
  );
}

class TimeSyncApp extends StatelessWidget {
  const TimeSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimeSync',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: const SplashScreen(),
    );
  }
}
```

---

## ▶️ Adım 9: İlk Çalıştırma

### Projeyi Çalıştır
```bash
# Emulator'ü başlat (eğer başlatmadıysanız)
flutter emulators --launch TimeSync_Test

# Uygulamayı çalıştır
flutter run

# Veya VS Code'da F5'e basın
```

### Hot Reload Test
- Kod değişikliği yapın
- Terminal'de `r` basın (hot reload)
- Veya `R` basın (hot restart)

---

## 🧪 Adım 10: İlk Test

```bash
code test/widget_test.dart
```

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timesync_flutter/main.dart';

void main() {
  testWidgets('Splash screen shows logo', (WidgetTester tester) async {
    await tester.pumpWidget(const TimeSyncApp());
    
    expect(find.text('TimeSync'), findsOneWidget);
    expect(find.text('Zamanın Senin Kontrolünde'), findsOneWidget);
  });
}
```

```bash
# Testi çalıştır
flutter test
```

---

## ✅ Kurulum Kontrol Listesi

- [ ] Flutter SDK indirildi ve PATH'e eklendi
- [ ] `flutter doctor` çalıştı ve sorunlar çözüldü
- [ ] Android Studio kuruldu
- [ ] Android SDK indirildi
- [ ] Android licenses kabul edildi
- [ ] Emulator oluşturuldu
- [ ] Flutter projesi oluşturuldu
- [ ] Dependencies eklendi (`pubspec.yaml`)
- [ ] Klasör yapısı oluşturuldu
- [ ] Tema dosyaları oluşturuldu
- [ ] Splash screen oluşturuldu
- [ ] İlk uygulama çalıştı ✅

---

## 🆘 Sık Karşılaşılan Sorunlar

### Problem: flutter command not found
**Çözüm:**
```bash
export PATH="$PATH:$HOME/flutter/bin"
source ~/.bashrc
```

### Problem: Android licenses not accepted
**Çözüm:**
```bash
flutter doctor --android-licenses
# Tüm sorulara 'y' yanıtı verin
```

### Problem: No devices found
**Çözüm:**
```bash
# Emulator listesini kontrol et
flutter emulators

# Emulator başlat
flutter emulators --launch <emulator_id>
```

### Problem: Build failed
**Çözüm:**
```bash
# Cache temizle
flutter clean
flutter pub get

# Tekrar dene
flutter run
```

---

## 📚 Kaynaklar

- [Flutter Resmi Dokümantasyon](https://docs.flutter.dev)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Widget Catalog](https://docs.flutter.dev/development/ui/widgets)
- [Riverpod Dokümantasyon](https://riverpod.dev)

---

## 🎓 Öğrenme Yolu

1. **Gün 1-2:** Flutter basics, Widgets, Layout
2. **Gün 3-4:** Navigation, State Management
3. **Gün 5-7:** HTTP calls, Forms, Validation
4. **Hafta 2:** Ortak widget'ları oluştur
5. **Hafta 3:** Ana sayfaları implement et
6. **Hafta 4+:** Modülleri tek tek tamamla

---

**Sonraki Adım:** Welcome Screen oluşturma 🚀

Flutter SDK indirmesi tamamlandıktan sonra yukarıdaki adımları takip edin!
