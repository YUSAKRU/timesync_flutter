---
trigger: always_on
glob: "**/*.{dart,yaml,md}"
description: TimeSync Project Workspace Rules
---

# TimeSync Workspace Rules (Updated 19 Dec 2025)

Bu belge, TimeSync projesinin mimari standartlarını, kodlama kurallarını ve güncel faz durumunu içerir. Tüm geliştirmeler bu kurallara uygun yapılmalıdır.

## 1. Proje Yapısı ve Çalışma Alanı

- **Ana Dizin:** Tüm Flutter operasyonları `timesync_flutter/` dizininde yürütülmelidir. Kök dizinde Flutter dosyası oluşturulmamalıdır.
- **Dizin Yapısı:**
  - `lib/core/`: Sabitler, temalar, ortak servisler (Storage, Network).
  - `lib/data/`: Modeller, repository implementasyonları.
  - `lib/presentation/`: Ekranlar (Customer, Employee, Business, Admin modülleri).
  - `lib/core/providers/`: Riverpod state yönetim sınıfları.

## 2. Kodlama Standartları

- **Dart/Flutter:** 
  - `const` constructor kullanımı zorunludur.
  - Satır uzunluğu: 80 karakter.
  - Material 3 tasarım prensipleri uygulanmalıdır.
- **State Management:** 
  - **Riverpod** tek yetkili state yönetim sistemidir.
  - Karmaşık state'ler için `StateNotifierProvider` ve `AsyncValue` yapısı kullanılmalıdır.
- **Veri Saklama:** 
  - Token ve kullanıcı ID gibi hassas veriler `flutter_secure_storage` (via `StorageService`) üzerinden saklanmalıdır.
  - Genel ayarlar `SharedPreferences` üzerinden saklanabilir.

## 3. UI Standartları

- **Renkler:** `AppColors` sınıfındaki sabitler kullanılmalıdır.
- **Metin Stilleri:** `AppTextStyles` sınıfındaki sabitler kullanılmalıdır.
- **Tipografi:** h1-h4 başlık hiyerarşisine uyulmalıdır.
- **Performans:** Liste bazlı ekranlarda (Discover, Reviews) **Infinite Scroll** ve **Lazy Loading** kullanılmalıdır.

## 4. Git ve Geliştirme Akışı

- **Commit Formatı:** `feat:`, `fix:`, `refactor:`, `style:`, `docs:`.
- **Dizin:** Git işlemleri `timesync_flutter/` dizinden yapılmalıdır.

## 5. Güncel Proje Durumu

✅ **Faz 1-8:** TAMAMLANDI (UI, Riverpod, Mock API, QR, Push, UI/UX).
✅ **Faz 9.1:** Secure Storage Tamamlandı.
✅ **Faz 9.2:** Lazy Loading & Pagination (Infinite Scroll) Tamamlandı.

## 6. Kritik Yasaklar (What NOT to Do)

- ❌ Kök dizinde Flutter dosyası oluşturma.
- ❌ Hardcoded renk veya metin stili kullanma.
- ❌ Hassas verileri `SharedPreferences` içerisinde düz metin olarak saklama.
- ❌ Riverpod dışında karmaşık state yönetimi kullanma.

---
*Not: Bu belge `.agent/rules/antigravity-timesync-workspace-rules.md` dosyasına aktarılmak üzere hazırlanmıştır.*
