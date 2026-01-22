# 🕐 TimeSync - Modern Randevu Yönetim Sistemi

TimeSync, işletmeler ve müşteriler için geliştirilmiş, modern ve kullanıcı dostu bir randevu yönetim platformudur. Kuaför, dişçi, spa, diyetisyen ve benzeri hizmet sektörlerinde çalışan işletmelerin randevu süreçlerini dijitalleştirmek için tasarlanmıştır.

## 📋 İçindekiler

- [Özellikler](#-özellikler)
- [Proje Yapısı](#-proje-yapısı)
- [Kullanıcı Rolleri](#-kullanıcı-rolleri)
- [Kurulum](#-kurulum)
- [Sayfa Açıklamaları](#-sayfa-açıklamaları)
- [Teknolojiler](#-teknolojiler)
- [Geliştirme Planı](#-geliştirme-planı)
- [Ekran Görüntüleri](#-ekran-görüntüleri)

## ✨ Özellikler

### 🎯 Genel Özellikler
- ✅ **Responsive Tasarım** - Mobil-first yaklaşım ile tüm cihazlara uyumlu
- ✅ **Dark Mode Desteği** - Göz dostu karanlık tema
- ✅ **Modern UI/UX** - Material Design ilkelerine uygun arayüz
- ✅ **Çoklu Tema Desteği** - Her rol için özel renk paleti
- ✅ **Animasyonlar** - Akıcı geçişler ve etkileşimler

### 👤 Müşteri Özellikleri
- 🔍 İşletme arama ve kategori filtreleme
- 📅 Hızlı randevu oluşturma
- ⏰ Yaklaşan ve geçmiş randevuları görüntüleme
- 📱 QR kod ile check-in
- 🔔 Bildirim sistemi
- ⭐ İşletmeleri değerlendirme

### 💼 İşletme Özellikleri
- 📊 Detaylı dashboard ve istatistikler
- 👥 Çalışan yönetimi
- 📅 Randevu takvimi
- 💰 Gelir/ciro takibi
- 📈 Performans raporları
- ⚙️ İşletme ayarları

### 👨‍💼 Çalışan Özellikleri
- 📋 Günlük randevu listesi
- ⏱️ Timeline görünümü
- ✅ Randevu durumu güncelleme
- 📊 Kişisel performans metrikleri
- 📱 QR kod okuyucu

### 🔐 Süper Admin Özellikleri
- 🌐 Tüm işletmeleri yönetme
- 📊 Sistem geneli istatistikler
- 👥 Kullanıcı yönetimi
- 💳 Ödeme ve abonelik takibi
- 🛠️ Sistem ayarları

## 📁 Proje Yapısı

\`\`\`
timeSync/
├── public/                      # Statik dosyalar ve ana giriş sayfası
│   └── index.html              # Ana karşılama sayfası
├── src/                        # Kaynak kodlar
│   ├── assets/                 # Statik asset'ler
│   │   ├── css/               # Stil dosyaları
│   │   │   └── common.css     # Ortak CSS stilleri
│   │   └── js/                # JavaScript dosyaları
│   │       ├── common.js      # Ortak fonksiyonlar
│   │       └── tailwind-config.js  # Tailwind konfigürasyonu
│   ├── components/            # Tekrar kullanılabilir bileşenler (ileride)
│   └── pages/                 # Sayfa dosyaları
│       ├── admin/             # Süper Admin sayfaları
│       │   ├── dashboard.html
│       │   ├── dashboard-v2.html
│       │   ├── dashboard-v3.html
│       │   ├── dashboard-v4.html
│       │   └── dashboard-v5.html
│       ├── business/          # İşletme paneli sayfaları
│       │   ├── dashboard.html
│       │   ├── dashboard-v2.html
│       │   ├── dashboard-v3.html
│       │   ├── dashboard-v4.html
│       │   └── dashboard-v5.html
│       ├── customer/          # Müşteri sayfaları
│       │   ├── login.html
│       │   ├── discover.html
│       │   ├── appointments.html
│       │   ├── appointments-v2.html
│       │   └── appointments-v3.html
│       └── employee/          # Çalışan sayfaları
│           ├── dashboard.html
│           ├── dashboard-v2.html
│           └── dashboard-v3.html
└── repo/                      # Orijinal dosyalar (backup)
    └── stitch_giri_ve_kar_lama_sayfas/
\`\`\`

## 👥 Kullanıcı Rolleri

### 1. 👤 Müşteri (Customer)
Ana kullanıcı grubu. İşletmeleri keşfeder ve randevu oluşturur.

**Sayfalar:**
- `login.html` - Giriş ve kayıt modalı
- `discover.html` - İşletme keşfet ekranı
- `appointments.html` - Randevularım (3 varyant)

### 2. 👨‍💼 Çalışan (Employee)
İşletmede çalışan personel. Günlük randevularını yönetir.

**Sayfalar:**
- `dashboard.html` - Ana çalışan ekranı (3 varyant)

### 3. 💼 İşletme (Business)
İşletme sahibi/yöneticisi. Tüm işletme operasyonlarını yönetir.

**Sayfalar:**
- `dashboard.html` - Ana yönetim paneli (5 farklı görünüm)

### 4. 🔐 Süper Admin (Super Admin)
Platform yöneticisi. Tüm sistemi kontrol eder.

**Sayfalar:**
- `dashboard.html` - Admin kontrol paneli (5 farklı görünüm)

## 🚀 Kurulum

### Gereksinimler
- Modern bir web tarayıcı (Chrome, Firefox, Safari, Edge)
- Live Server veya benzeri bir development server

### Adımlar

1. **Projeyi klonlayın:**
\`\`\`bash
git clone <repository-url>
cd timeSync
\`\`\`

2. **Live Server ile başlatın:**
\`\`\`bash
# VS Code Live Server extension kullanıyorsanız:
# public/index.html dosyasını açın ve "Go Live" butonuna tıklayın

# veya Python ile:
cd public
python3 -m http.server 8000

# veya Node.js ile:
npx http-server public -p 8000
\`\`\`

3. **Tarayıcınızda açın:**
\`\`\`
http://localhost:8000
\`\`\`

## 📄 Sayfa Açıklamaları

### Ana Giriş Sayfası
**Dosya:** `public/index.html`
- Müşteri ve İşletme için ayrı giriş kartları
- Özellik kartları (No-Show Koruması, 7/24 Randevu, vb.)
- CTA (Call-to-Action) bölümü
- Responsive tasarım

### Müşteri Sayfaları

#### 1. Login (Giriş/Kayıt)
**Dosya:** `src/pages/customer/login.html`
- Bottom sheet modal tasarımı
- Müşteri/İşletme segmented button
- Email ve şifre ile giriş
- Google ve Apple ile sosyal giriş
- Şifremi unuttum özelliği

#### 2. Discover (Keşfet)
**Dosya:** `src/pages/customer/discover.html`
- İşletme arama çubuğu
- Kategori filtreleme (Kuaför, Dişçi, Spa, vb.)
- İşletme kartları (rating, konum, çalışma saatleri)
- Randevu alma bottom sheet
- Hizmet seçimi wizard
- Personel seçimi
- Tarih ve saat seçimi

#### 3. Appointments (Randevularım)
**Dosyalar:** `appointments.html`, `appointments-v2.html`, `appointments-v3.html`
- Yaklaşan/Geçmiş tab sistemi
- QR kod ile check-in
- Aktif randevu kartı (ticket style)
- Yol tarifi linki
- Randevu iptal etme
- Alt navigasyon

### Çalışan Sayfaları

**Dosyalar:** `dashboard.html`, `dashboard-v2.html`, `dashboard-v3.html`
- Günlük performans istatistikleri
- Timeline görünümü
- Randevu kartları
- Durum güncelleme butonları
- QR kod okuyucu

### İşletme Paneli

**Dosyalar:** `dashboard.html` ile `dashboard-v5.html` arası
- Günlük/haftalık/aylık ciro
- Randevu istatistikleri
- Çalışan listesi
- Yaklaşan randevular
- Performans grafikleri
- Hizmet yönetimi

### Admin Paneli

**Dosyalar:** `dashboard.html` ile `dashboard-v5.html` arası
- Toplam gelir ve işletme sayısı
- Aktif kullanıcı metrikleri
- İşletme listesi ve yönetimi
- Ödeme ve abonelik takibi
- Sistem ayarları

## 🛠️ Teknolojiler

### Frontend
- **HTML5** - Semantic markup
- **Tailwind CSS** - Utility-first CSS framework
- **JavaScript (Vanilla)** - Client-side logic
- **Google Fonts** - Typography
  - Spline Sans
  - Plus Jakarta Sans
  - Inter
  - Manrope
- **Material Symbols** - Icon library

### Özellikler
- **Dark Mode** - CSS variables ile tema desteği
- **Responsive Design** - Mobile-first approach
- **Animations** - CSS transitions ve keyframes
- **Local Storage** - Tema tercihi kaydetme

## 📅 Geliştirme Planı

### ✅ Faz 1: Proje Yapısı (Tamamlandı)
- [x] Klasör yapısı oluşturma
- [x] Tüm sayfaları organize etme
- [x] Ortak CSS/JS dosyaları oluşturma
- [x] README dokümantasyonu

### 🔄 Faz 2: Component Geliştirme (Planlanan)
- [ ] Navbar component
- [ ] Bottom navigation component
- [ ] Modal/Bottom sheet component
- [ ] Card components
- [ ] Form components
- [ ] Button variants

### 🔄 Faz 3: JavaScript Fonksiyonellik (Planlanan)
- [ ] Routing sistemi
- [ ] State management
- [ ] Form validasyonları
- [ ] API entegrasyonu (mock)
- [ ] QR kod oluşturma/okuma
- [ ] Filtreleme ve arama

### 🔄 Faz 4: Backend Entegrasyonu (Planlanan)
- [ ] API endpoint tasarımı
- [ ] Database schema
- [ ] Authentication sistemi
- [ ] RESTful API geliştirme
- [ ] Real-time özellikler (WebSocket)

### 🔄 Faz 5: Test ve Deployment (Planlanan)
- [ ] Unit testler
- [ ] Integration testler
- [ ] Performance optimization
- [ ] SEO optimizasyonu
- [ ] Production deployment

## 📸 Ekran Görüntüleri

### Ana Sayfa
Modern ve kullanıcı dostu karşılama ekranı, müşteri ve işletme için ayrı giriş kartları içerir.

### Müşteri - Keşfet Ekranı
İşletmeleri kategori bazında filtreleyebilir, arama yapabilir ve detaylı bilgi görüntüleyebilirsiniz.

### Müşteri - Randevularım
QR kod ile check-in özelliği, aktif ve geçmiş randevuları görüntüleme.

### Çalışan Dashboard
Günlük timeline görünümü, randevu yönetimi ve performans metrikleri.

### İşletme Paneli
Gelir takibi, çalışan yönetimi ve detaylı analitik raporlar.

### Admin Paneli
Sistem geneli istatistikler, işletme yönetimi ve kullanıcı kontrolü.

## 🤝 Katkıda Bulunma

Bu proje aktif olarak geliştirilmektedir. Katkılarınızı bekliyoruz!

1. Fork edin
2. Feature branch oluşturun (\`git checkout -b feature/amazing-feature\`)
3. Commit edin (\`git commit -m 'feat: Add amazing feature'\`)
4. Push edin (\`git push origin feature/amazing-feature\`)
5. Pull Request açın

## 📝 Lisans

Bu proje özel bir projedir. Tüm hakları saklıdır.

## 👨‍💻 Geliştirici

TimeSync - Modern Randevu Yönetim Sistemi

## 📞 İletişim

Sorularınız için lütfen issue açın veya iletişime geçin.

---

**Not:** Bu proje şu anda frontend tasarım aşamasındadır. Backend entegrasyonu gelecek fazlarda eklenecektir.

## 🎨 Renk Paleti

### Ana Temalar
- **Primary Green:** \`#36e27b\` - Ana aksiyon rengi
- **Primary Dark:** \`#2ab561\` - Hover durumları
- **Accent Purple:** \`#BA68C8\` - Vurgu rengi
- **Accent Orange:** \`#FF8A65\` - İkincil vurgu

### Dark Mode
- **Background:** \`#112117\` - Ana arka plan
- **Surface:** \`#1b3224\` - Kart arka planı
- **Text Secondary:** \`#95c6a9\` - İkincil metin

### Light Mode
- **Background:** \`#f6f8f7\` - Ana arka plan
- **Surface:** \`#ffffff\` - Kart arka planı
- **Text:** \`#111827\` - Ana metin

## 🔧 Özelleştirme

### Tema Değiştirme
\`tailwind-config.js\` dosyasından renkleri özelleştirebilirsiniz:

\`\`\`javascript
colors: {
    "primary": "#36e27b",  // Buradan değiştirin
    "primary-dark": "#2ab561",
    // ...
}
\`\`\`

### Font Değiştirme
HTML head bölümünden Google Fonts linklerini güncelleyin.

## 📚 Dokümantasyon

Detaylı komponent ve API dokümantasyonu için \`/docs\` klasörünü inceleyiniz. (Yakında eklenecek)

---

**Son Güncelleme:** 18 Aralık 2025
