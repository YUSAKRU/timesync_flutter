# TimeSync Teknoloji Yığını (Tech Stack)

Bu belge, TimeSync projesinde kullanılan temel teknolojileri, kütüphaneleri ve mimari tercihleri detaylandırmaktadır.

## 1. Çekirdek Teknolojiler
- **Flutter & Dart:** Uygulamanın temel framework'ü. Tek bir kod tabanından yüksek performanslı Android ve iOS çıktıları almak için tercih edildi.
- **Material 3:** Modern, dinamik ve kullanıcı dostu bir arayüz tasarımı için en güncel tasarım dili kullanıldı.

## 2. Durum Yönetimi (State Management)
- **Riverpod:** Uygulamanın "beyni". Test edilebilirliği yüksek, güvenli ve reaktif bir durum yönetimi sağlar.
  - *Neden?* Compile-time safety sunması ve bağımlılık yönetimini kolaylaştırması sebebiyle seçildi.

## 3. Veri ve Depolama
- **Flutter Secure Storage:** JWT tokenları ve kullanıcı ID gibi hassas verilerin cihazda şifreli olarak saklanmasını sağlar.
- **Shared Preferences:** Tema seçimi gibi hassas olmayan, basit uygulama ayarlarının saklanması için kullanılır.
- **Dio:** Güçlü bir HTTP istemcisi. Interceptor desteği sayesinde otomatik token yenileme ve loglama süreçlerini yönetir.

## 4. Kullanıcı Deneyimi ve Görselleştirme
- **Cached Network Image:** Resimlerin cihaz hafızasına kaydedilerek internet kullanımını azaltır ve hızı artırır.
- **Shimmer:** Veriler yüklenirken göze hoş gelen "iskelet" yükleme ekranları sunar.
- **Google Fonts:** Uygulamanın tipografik kalitesini artırmak için kullanılır.
- **Flutter SVG:** Vektörel ikonların her çözünürlükte keskin görünmesini sağlar.

## 5. Güvenlik ve Kimlik Doğrulama
- **Firebase Core & Messaging:** Anlık bildirimler (Push Notifications) ve uygulama altyapısı için entegre edildi.
- **Crypto:** Şifreleme ve veri bütünlüğü kontrolleri için kullanılır.

## 6. Araçlar ve Kod Üretimi
- **Freezed & JSON Serializable:** Veri modellerinin hatasız ve hızlı bir şekilde oluşturulmasını sağlar.
- **Go Router:** Karmaşık navigasyon senaryolarını ve derin linklemeyi (Deep Linking) yönetmek için hazırlandı.
- **QR Flutter & Mobile Scanner:** QR kod üretimi ve tarama özellikleri için entegre edildi.

---
*Son Güncelleme: 19 Aralık 2025*
