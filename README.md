# 🦋 TimeSync Flutter App

Modern randevu yönetim sistemi - Flutter ile geliştirilmiştir.

## 📱 Proje Durumu

✅ **Tüm Modüller Tamamlandı!**

### Tamamlanan Modüller

#### 🎨 Core & Theme System
- ✅ Color palette (15+ colors, 2 gradients)
- ✅ Typography system (13 text styles with Google Fonts)
- ✅ Light & Dark themes with Material Design 3
- ✅ Splash screen with animations

#### 👤 Customer Module (7 screens)
- ✅ Discover screen - Business browsing with search & categories
- ✅ Business detail - Services, employees, reviews, about tabs
- ✅ Service selection - Multi-select with total calculator
- ✅ Time selection - Date picker, employee selector, time slots
- ✅ Booking confirmation - Summary and price breakdown
- ✅ Appointments - Upcoming/past tabs with status badges
- ✅ Profile - Stats, settings, logout

#### 💼 Employee Module (3 screens)
- ✅ Home - Stats, today's appointments, quick actions
- ✅ Schedule - Date picker, timeline with appointments
- ✅ Profile - Performance metrics, settings

#### 🏢 Business Owner Module (4 screens)
- ✅ Dashboard - Revenue tracking, weekly chart, stats
- ✅ Employees - Employee management with detailed stats
- ✅ Services - Service list with CRUD operations
- ✅ Settings - Business info, hours, preferences, subscription

#### ⚡ Super Admin Module (3 screens)
- ✅ Dashboard - System-wide stats, revenue chart, activities
- ✅ Businesses - All businesses with filters and management
- ✅ Settings - System configuration, security, maintenance

#### 🧭 Navigation
- ✅ Welcome screen with role selection
- ✅ Auth screens (Login & Register with social login)
- ✅ Customer bottom navigation (3 tabs)
- ✅ Employee bottom navigation (3 tabs)
- ✅ Business bottom navigation (4 tabs)
- ✅ Admin bottom navigation (3 tabs)

## 🚀 Kurulum

### 1. Flutter SDK Kontrol
```bash
flutter doctor
```

### 2. Dependencies İndir
```bash
cd timesync_flutter
flutter pub get
```

### 3. Web'de Çalıştır (Önerilen)
```bash
flutter run -d chrome --web-port=8080
```

### 4. Emulator'de Çalıştır
```bash
# Emulator listesi
flutter emulators

# Emulator başlat
flutter emulators --launch <emulator_id>

# Uygulamayı çalıştır
flutter run
```

## 📦 Kullanılan Paketler

```yaml
dependencies:
  flutter_riverpod: ^2.6.1      # State management
  go_router: ^13.2.5            # Navigation
  google_fonts: ^6.1.0          # Typography
  cached_network_image: ^3.3.0  # Image caching
  dio: ^5.4.0                   # HTTP client
  qr_flutter: ^4.1.0            # QR code generator
  mobile_scanner: ^3.5.5        # QR code scanner
  flutter_svg: ^2.0.9           # SVG images
  shared_preferences: ^2.2.2    # Local storage
  intl: ^0.18.1                 # Date formatting
  uuid: ^4.2.2                  # UUID generator
```

## 🗂️ Proje Yapısı

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart         # 15+ colors, 2 gradients
│   │   ├── app_text_styles.dart    # 13 text styles
│   │   └── app_constants.dart      # App configuration
│   └── theme/
│       └── app_theme.dart          # Light & Dark themes
│
├── presentation/
│   ├── splash/
│   │   └── splash_screen.dart      # Animated splash
│   ├── welcome/
│   │   └── welcome_screen.dart     # Role selection
│   ├── auth/
│   │   ├── login_screen.dart       # Login modal
│   │   └── register_screen.dart    # Register modal
│   ├── customer/
│   │   ├── discover_screen.dart    # Browse businesses
│   │   ├── business_detail_screen.dart
│   │   ├── appointments_screen.dart
│   │   ├── profile_screen.dart
│   │   └── booking/                # Booking flow (3 screens)
│   ├── employee/
│   │   ├── employee_home_screen.dart
│   │   ├── employee_schedule_screen.dart
│   │   └── employee_profile_screen.dart
│   ├── business/
│   │   ├── business_dashboard_screen.dart
│   │   ├── business_employees_screen.dart
│   │   ├── business_services_screen.dart
│   │   └── business_settings_screen.dart
│   ├── admin/
│   │   ├── admin_dashboard_screen.dart
│   │   ├── admin_businesses_screen.dart
│   │   └── admin_settings_screen.dart
│   └── navigation/
│       ├── main_navigation.dart        # Customer nav
│       ├── employee_navigation.dart    # Employee nav
│       ├── business_navigation.dart    # Business nav
│       └── admin_navigation.dart       # Admin nav
│
└── main.dart                       # Entry point
```

## 🎨 Tasarım Sistemi

### Renk Paleti
- **Primary:** `#36E27B` (Yeşil)
- **Primary Dark:** `#2AB561`
- **Accent Purple:** `#BA68C8`
- **Accent Orange:** `#FF8A65`
- **Background Dark:** `#112117`
- **Surface Dark:** `#1B3224`

### Typography (Google Fonts)
- **Display:** Spline Sans (32px, 28px)
- **Headings:** Plus Jakarta Sans (24px, 20px, 18px, 16px)
- **Body:** Plus Jakarta Sans (16px, 14px, 12px)

## 🔥 Özellikler

### Müşteri Özellikleri
- ✨ İşletme keşfet & arama
- 📅 Çoklu hizmet seçimi
- ⏰ Randevu oluşturma
- 📋 Randevu yönetimi
- 👤 Profil & ayarlar

### Çalışan Özellikleri
- 📊 Günlük istatistikler
- 📆 Takvim & timeline görünümü
- ⚡ Hızlı aksiyonlar
- 📈 Performans metrikleri

### İşletme Sahibi Özellikleri
- 💰 Gelir takibi & grafikler
- 👥 Çalışan yönetimi
- 🛠️ Hizmet/fiyat listesi
- ⚙️ İşletme ayarları

### Super Admin Özellikleri
- 🌐 Sistem istatistikleri
- 🏢 İşletme yönetimi
- 🔐 Güvenlik & bakım
- 📊 Gelir raporları

## 🚧 Devam Eden Geliştirmeler

- [ ] State management implementation (Riverpod providers)
- [ ] API integration (mock data)
- [ ] QR code check-in system
- [ ] Push notifications
- [ ] Reviews & ratings system
- [ ] Advanced analytics

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır.

## 🛠️ Geliştirme

### Hot Reload
```bash
# Terminal'de uygulamayı çalıştırdıktan sonra
r  # Hot reload
R  # Hot restart
q  # Quit
```

### Build APK
```bash
flutter build apk --release
```

### Test
```bash
flutter test
```

## 📚 Kaynaklar

- [Flutter Dokümantasyon](https://docs.flutter.dev)
- [Material Design 3](https://m3.material.io)
- [Riverpod](https://riverpod.dev)

---

**Version:** 1.0.0  
**Last Update:** 18 Aralık 2025
