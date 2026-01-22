# 🦋 TimeSync - Flutter Migration Plan

**Tarih:** 18 Aralık 2025  
**Durum:** 🚀 Flutter'a Geçiş Başladı

---

## 📋 Migration Stratejisi

### Faz 1: Hazırlık ve Setup (1 hafta)
- [x] Flutter kurulumu
- [ ] Android Studio / VS Code setup
- [ ] Flutter projesi oluşturma
- [ ] Dependency'leri belirleme
- [ ] Proje yapısı tasarımı

### Faz 2: Core & Theme (1 hafta)
- [ ] Tema sistemi (renk paleti, typography)
- [ ] Ortak widget'lar (buttons, cards, inputs)
- [ ] Routing yapısı (GoRouter)
- [ ] State management (Riverpod/Provider)
- [ ] API service katmanı

### Faz 3: Ana Sayfalar (2 hafta)
- [ ] Splash Screen
- [ ] Welcome/Onboarding
- [ ] Login/Register
- [ ] Bottom Navigation
- [ ] Ana layout'lar

### Faz 4: Müşteri Modülü (2 hafta)
- [ ] Discover (İşletme keşfet)
- [ ] Search & Filters
- [ ] Business Detail
- [ ] Appointment Booking Flow
- [ ] My Appointments
- [ ] QR Code generation

### Faz 5: Çalışan Modülü (1 hafta)
- [ ] Employee Dashboard
- [ ] Daily Timeline
- [ ] Appointment Management
- [ ] QR Code Scanner
- [ ] Performance Stats

### Faz 6: İşletme Modülü (2 hafta)
- [ ] Business Dashboard
- [ ] Revenue Stats
- [ ] Employee Management
- [ ] Service Management
- [ ] Calendar View
- [ ] Reports

### Faz 7: Admin Modülü (1 hafta)
- [ ] Admin Dashboard
- [ ] Business Management
- [ ] User Management
- [ ] Payment Tracking
- [ ] System Settings

### Faz 8: Polish & Testing (2 hafta)
- [ ] Animations & Transitions
- [ ] Error Handling
- [ ] Loading States
- [ ] Unit Tests
- [ ] Widget Tests
- [ ] Integration Tests

---

## 📦 Flutter Packages (Gerekli)

### Core
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # UI & Styling
  google_fonts: ^6.1.0
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.0
  
  # Navigation
  go_router: ^13.0.0
  
  # State Management
  riverpod: ^2.4.9
  flutter_riverpod: ^2.4.9
  
  # Storage
  shared_preferences: ^2.2.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # Network
  dio: ^5.4.0
  retrofit: ^4.0.3
  
  # QR Code
  qr_flutter: ^4.1.0
  mobile_scanner: ^3.5.5
  
  # Utils
  intl: ^0.18.1
  uuid: ^4.2.2
  
  # Firebase (opsiyonel)
  firebase_core: ^2.24.2
  firebase_auth: ^4.16.0
  firebase_messaging: ^14.7.9
```

---

## 🗂️ Flutter Proje Yapısı

```
timesync_flutter/
├── lib/
│   ├── main.dart                    # Entry point
│   │
│   ├── core/                        # Core functionality
│   │   ├── constants/
│   │   │   ├── app_colors.dart
│   │   │   ├── app_text_styles.dart
│   │   │   └── app_constants.dart
│   │   ├── theme/
│   │   │   └── app_theme.dart
│   │   ├── router/
│   │   │   └── app_router.dart
│   │   └── utils/
│   │       ├── helpers.dart
│   │       └── validators.dart
│   │
│   ├── data/                        # Data layer
│   │   ├── models/
│   │   │   ├── user.dart
│   │   │   ├── business.dart
│   │   │   ├── appointment.dart
│   │   │   └── service.dart
│   │   ├── repositories/
│   │   │   ├── auth_repository.dart
│   │   │   ├── business_repository.dart
│   │   │   └── appointment_repository.dart
│   │   └── services/
│   │       ├── api_service.dart
│   │       └── storage_service.dart
│   │
│   ├── presentation/                # UI layer
│   │   ├── common/                  # Shared widgets
│   │   │   ├── widgets/
│   │   │   │   ├── custom_button.dart
│   │   │   │   ├── custom_text_field.dart
│   │   │   │   ├── custom_card.dart
│   │   │   │   └── bottom_nav_bar.dart
│   │   │   └── layouts/
│   │   │       └── main_layout.dart
│   │   │
│   │   ├── splash/
│   │   │   └── splash_screen.dart
│   │   │
│   │   ├── welcome/
│   │   │   └── welcome_screen.dart
│   │   │
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   └── register_screen.dart
│   │   │
│   │   ├── customer/                # Müşteri modülü
│   │   │   ├── discover/
│   │   │   │   ├── discover_screen.dart
│   │   │   │   └── widgets/
│   │   │   ├── appointment/
│   │   │   │   ├── appointment_list_screen.dart
│   │   │   │   ├── appointment_detail_screen.dart
│   │   │   │   └── widgets/
│   │   │   └── booking/
│   │   │       ├── booking_screen.dart
│   │   │       └── widgets/
│   │   │
│   │   ├── employee/                # Çalışan modülü
│   │   │   ├── dashboard/
│   │   │   └── widgets/
│   │   │
│   │   ├── business/                # İşletme modülü
│   │   │   ├── dashboard/
│   │   │   └── widgets/
│   │   │
│   │   └── admin/                   # Admin modülü
│   │       ├── dashboard/
│   │       └── widgets/
│   │
│   └── providers/                   # Riverpod providers
│       ├── auth_provider.dart
│       ├── business_provider.dart
│       └── appointment_provider.dart
│
├── assets/                          # Assets
│   ├── images/
│   ├── icons/
│   └── fonts/
│
├── test/                            # Tests
│   ├── unit/
│   ├── widget/
│   └── integration/
│
├── pubspec.yaml                     # Dependencies
└── README.md
```

---

## 🎨 Renk Paleti Migration

### HTML → Flutter

```dart
// lib/core/constants/app_colors.dart

import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
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
  
  // Gradients
  static const primaryGradient = LinearGradient(
    colors: [primary, accentPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
```

---

## 🔤 Typography Migration

```dart
// lib/core/constants/app_text_styles.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Headings
  static TextStyle h1 = GoogleFonts.splineSans(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );
  
  static TextStyle h2 = GoogleFonts.splineSans(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );
  
  static TextStyle h3 = GoogleFonts.splineSans(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  // Body
  static TextStyle bodyLarge = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  
  static TextStyle bodyMedium = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  
  static TextStyle bodySmall = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  
  // Button
  static TextStyle button = GoogleFonts.splineSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
}
```

---

## 🚀 İlk Adımlar

### 1. Flutter Kurulumu
```bash
# Flutter SDK'yı PATH'e ekle
export PATH="$PATH:$HOME/flutter/bin"

# Kurulumu kontrol et
flutter doctor

# Eksikleri tamamla
flutter doctor --android-licenses
```

### 2. Proje Oluşturma
```bash
cd ~/Documents/projects/sistem-analiz-ve-tasarımı/timeSync
flutter create timesync_flutter --org com.timesync
cd timesync_flutter
```

### 3. İlk Çalıştırma
```bash
# Emulator başlat
flutter emulators --launch <emulator_id>

# Uygulamayı çalıştır
flutter run
```

---

## 📱 HTML → Flutter Widget Dönüşümleri

### Example 1: Button
**HTML:**
```html
<button class="bg-primary hover:bg-primary-dark text-white font-bold py-3 px-6 rounded-xl">
  Giriş Yap
</button>
```

**Flutter:**
```dart
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  child: Text('Giriş Yap', style: AppTextStyles.button),
)
```

### Example 2: Card
**HTML:**
```html
<div class="bg-surface-dark rounded-2xl p-6 shadow-lg">
  <h3>Title</h3>
  <p>Content</p>
</div>
```

**Flutter:**
```dart
Container(
  padding: EdgeInsets.all(24),
  decoration: BoxDecoration(
    color: AppColors.surfaceDark,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Column(
    children: [
      Text('Title', style: AppTextStyles.h3),
      SizedBox(height: 8),
      Text('Content', style: AppTextStyles.bodyMedium),
    ],
  ),
)
```

---

## 🎯 Öncelikli Sayfalar

### Sprint 1 (1. Hafta)
1. ✅ Splash Screen
2. ✅ Welcome Screen  
3. ✅ Login/Register
4. ✅ Bottom Navigation

### Sprint 2 (2. Hafta)
1. Discover Screen (kategori + arama)
2. Business List
3. Business Detail
4. Booking Flow (Wizard)

### Sprint 3 (3. Hafta)
1. My Appointments
2. Appointment Detail
3. QR Code Screen
4. Profile Screen

---

## 🧪 Testing Stratejisi

```dart
// test/widget/welcome_screen_test.dart
void main() {
  testWidgets('Welcome screen shows buttons', (tester) async {
    await tester.pumpWidget(MaterialApp(home: WelcomeScreen()));
    
    expect(find.text('Müşteri Girişi'), findsOneWidget);
    expect(find.text('İşletme Girişi'), findsOneWidget);
  });
}
```

---

## 📊 Tahmini Timeline

| Faz | Süre | Bitış |
|-----|------|-------|
| Setup & Core | 1 hafta | Hafta 1 |
| Ana Sayfalar | 1 hafta | Hafta 2 |
| Müşteri Modülü | 2 hafta | Hafta 4 |
| Çalışan Modülü | 1 hafta | Hafta 5 |
| İşletme Modülü | 2 hafta | Hafta 7 |
| Admin Modülü | 1 hafta | Hafta 8 |
| Testing & Polish | 2 hafta | Hafta 10 |

**Toplam:** ~10 hafta (2.5 ay)

---

## 💡 Best Practices

1. **Widget Naming:** `CustomButton`, `BusinessCard`, `AppointmentItem`
2. **File Naming:** `snake_case.dart`
3. **Class Naming:** `PascalCase`
4. **Constant Naming:** `camelCase`
5. **Folder Structure:** Feature-based organization
6. **State Management:** Riverpod providers
7. **API Calls:** Repository pattern
8. **Error Handling:** Try-catch + global error handler
9. **Loading States:** Shimmer effects
10. **Null Safety:** Always use null safety

---

## 🔄 HTML vs Flutter Comparison

| HTML/CSS | Flutter Equivalent |
|----------|-------------------|
| `<div>` | `Container`, `SizedBox` |
| `<button>` | `ElevatedButton`, `TextButton` |
| `<input>` | `TextField` |
| `<img>` | `Image.network`, `CachedNetworkImage` |
| CSS Grid | `GridView` |
| CSS Flex | `Row`, `Column`, `Flex` |
| CSS absolute | `Stack`, `Positioned` |
| `padding` | `Padding`, `EdgeInsets` |
| `margin` | `SizedBox`, space between widgets |
| `border-radius` | `BorderRadius.circular()` |

---

**Hazırlayan:** GitHub Copilot  
**Next:** Flutter SDK kurulumu ve ilk proje oluşturma 🚀
