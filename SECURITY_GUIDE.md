# TimeSync Güvenlik ve Derleme Rehberi

Bu belge, uygulamanın güvenliğini sağlamak için kullanılan yöntemleri ve üretim (production) aşamasında dikkat edilmesi gereken adımları içerir.

## 1. Hassas Veri Yönetimi (Envied)

Uygulamada API anahtarları, Base URL'ler ve diğer gizli veriler doğrudan kod içine yazılmamalıdır. Bunun yerine `.env` dosyası ve `envied` paketi kullanılır.

### Kurulum ve Kullanım
1. Kök dizinde (timesync_flutter/) bir `.env` dosyası oluşturun.
2. Değişkenleri tanımlayın: `API_BASE_URL=https://...`
3. Aşağıdaki komutla obfuscated (karartılmış) Dart kodunu üretin:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

### Dikkat Edilmesi Gerekenler
- **ASLA** `.env` dosyasını Git'e pushlamayın.
- Yeni bir ekip üyesi geldiğinde `.env.example` dosyasını referans alarak kendi `.env` dosyasını oluşturmalıdır.

## 2. Güvenli Build Alma (Obfuscation)

Flutter uygulamaları tersine mühendislik ile kolayca decompile edilebilir. Bunu zorlaştırmak için Google'ın önerdiği "Obfuscation" yöntemini kullanıyoruz.

### Android / iOS APK/IPA Build Komutu:
```bash
flutter build apk --obfuscate --split-debug-info=build/app/outputs/symbols
```

- `--obfuscate`: Fonksiyon ve sınıf isimlerini anlamsız karakterlere dönüştürür.
- `--split-debug-info`: Hata raporlarını (crashlytics vb.) anlamlandırabilmek için gereken sembol dosyalarını dışarıya ayırır. Uygulama boyutunu da küçültür.

## 3. Güvenli Veri Saklama

- Kullanıcı tokenları, ID'leri gibi veriler asla `SharedPreferences` içinde düz metin olarak saklanmamalıdır.
- Bunun yerine `lib/core/services/storage_service.dart` üzerinden `FlutterSecureStorage` (AES şifreleme) kullanılmalıdır.

## 4. Kritik Kontrol Listesi (Mağaza Öncesi)
- [ ] Debug printleri (loglar) kaldırıldı mı?
- [ ] `.env` içindeki URL'ler canlı (production) ortama çekildi mi?
- [ ] Proguard/R8 aktif mi? (Android için varsayılandır).
- [ ] API Key'lerin geçerlilik alanları (restricted access) Google Cloud Console üzerinden sınırlandırıldı mı?

---
*Son Güncelleme: 19 Aralık 2025*
