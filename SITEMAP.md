# TimeSync - Site Haritası

## 🏠 Ana Sayfa
**URL:** `/public/index.html`

### Navigasyon:
- → Müşteri Girişi → `/src/pages/customer/login.html`
- → İşletme Girişi → `/src/pages/business/dashboard.html`
- → "Giriş Yap" butonu → `/src/pages/customer/login.html`

---

## 👤 MÜŞTERİ FLOW

### 1. Giriş/Kayıt
**URL:** `/src/pages/customer/login.html`
- Müşteri/İşletme toggle
- Email + Şifre giriş
- Google/Apple sosyal giriş
- Şifremi unuttum

**Navigasyon:**
- ✅ Başarılı giriş → `discover.html`
- 📝 Kayıt ol → (Aynı sayfada modal)

### 2. Keşfet (Discover)
**URL:** `/src/pages/customer/discover.html`
- Arama çubuğu
- Kategori filtreleri (Kuaför, Dişçi, Spa, Diyetisyen)
- İşletme kartları
  - Rating ve yorumlar
  - Konum bilgisi
  - Çalışma saatleri
  - "Randevu Al" butonu

**Navigasyon:**
- 🔍 Alt menü → Keşfet (aktif)
- 📅 Alt menü → `appointments.html`
- 👤 Alt menü → Profil
- "Randevu Al" → Bottom sheet (aynı sayfa)

**Bottom Sheet:**
1. Hizmet Seçimi
2. Personel Seçimi
3. Tarih ve Saat
4. "Onayla ve Öde" → `appointments.html`

### 3. Randevularım
**URL:** `/src/pages/customer/appointments.html`
**Varyantlar:** `appointments-v2.html`, `appointments-v3.html`

**Tabs:**
- Yaklaşan (aktif)
- Geçmiş

**Özellikler:**
- QR kod ile check-in
- Yol tarifi
- İptal etme
- Randevu detayları

**Navigasyon:**
- 🔍 Alt menü → `discover.html`
- 📅 Alt menü → Randevularım (aktif)
- 👤 Alt menü → Profil

---

## 👨‍💼 ÇALIŞAN FLOW

### Dashboard
**URL:** `/src/pages/employee/dashboard.html`
**Varyantlar:** `dashboard-v2.html`, `dashboard-v3.html`

**Özellikler:**
- Bugünkü performans (randevu sayısı, tamamlanan)
- Timeline görünümü
- Randevu kartları
  - Müşteri bilgisi
  - Hizmet detayı
  - Süre bilgisi
- QR kod okuyucu

**Randevu Durumları:**
- ⏰ Bekliyor
- 🚀 Başladı
- ✅ Tamamlandı
- ❌ İptal

---

## 💼 İŞLETME FLOW

### Yönetim Paneli
**URL:** `/src/pages/business/dashboard.html`
**Varyantlar:** `dashboard-v2.html`, `v3`, `v4`, `v5`

**Dashboard Özellikleri:**
- 💰 Günlük/Haftalık Ciro
- 📊 Randevu İstatistikleri
- 👥 Çalışan Listesi
- 📅 Yaklaşan Randevular
- 📈 Performans Grafikleri

**Menü Sekmeler:**
1. **Genel Bakış** (dashboard.html)
   - Ciro kartı
   - Randevu sayısı
   - Müşteri sayısı
   - Derecelendirme

2. **Randevular** (dashboard-v2.html)
   - Takvim görünümü
   - Randevu listesi
   - Filtreleme
   - Yeni randevu ekle

3. **Çalışanlar** (dashboard-v3.html)
   - Çalışan listesi
   - Performans metrikleri
   - Vardiya yönetimi
   - Yeni çalışan ekle

4. **Hizmetler** (dashboard-v4.html)
   - Hizmet listesi
   - Fiyatlandırma
   - Süre ayarları
   - Kategori yönetimi

5. **Raporlar** (dashboard-v5.html)
   - Gelir raporları
   - Müşteri analizi
   - Popüler hizmetler
   - Performans trendleri

---

## 🔐 SÜPER ADMİN FLOW

### Admin Paneli
**URL:** `/src/pages/admin/dashboard.html`
**Varyantlar:** `dashboard-v2.html`, `v3`, `v4`, `v5`

**Dashboard Özellikleri:**
- 💵 Toplam Gelir
- 🏢 Aktif İşletme Sayısı
- 👥 Aktif Kullanıcı Sayısı
- 📊 Platform Metrikleri

**Menü Sekmeler:**
1. **Genel Bakış** (dashboard.html)
   - Sistem geneli istatistikler
   - Günlük aktif kullanıcılar
   - Gelir grafikleri

2. **İşletmeler** (dashboard-v2.html)
   - İşletme listesi
   - Durum (Aktif/Pasif)
   - Abonelik bilgisi
   - Detaylı görüntüleme

3. **Kullanıcılar** (dashboard-v3.html)
   - Kullanıcı listesi
   - Rol yönetimi
   - Ban/Unban
   - Aktivite logları

4. **Ödemeler** (dashboard-v4.html)
   - Ödeme geçmişi
   - Abonelik takibi
   - İade işlemleri
   - Finansal raporlar

5. **Ayarlar** (dashboard-v5.html)
   - Sistem ayarları
   - Email template'leri
   - SMS konfigürasyonu
   - API ayarları

---

## 🎨 Varyant Farklılıkları

### Müşteri - Randevularım
- **v1:** QR kod sağda, aktif randevu vurgusu
- **v2:** Liste görünümü ağırlıklı
- **v3:** Kart görünümü, daha minimalist

### Çalışan - Dashboard
- **v1:** Timeline odaklı
- **v2:** Kart grid layout
- **v3:** Kompakt liste görünümü

### İşletme - Dashboard
- **v1:** Metric kartları + liste
- **v2:** Büyük istatistik kartları
- **v3:** Grafik ağırlıklı
- **v4:** Tablo görünümü
- **v5:** Karışık layout

### Admin - Dashboard
- **v1:** Sistem özeti
- **v2:** İşletme yönetimi
- **v3:** Kullanıcı yönetimi
- **v4:** Ödeme sistemi
- **v5:** Ayarlar paneli

---

## 🚀 Hızlı Test Senaryoları

### Müşteri Akışı
1. `public/index.html` → "Müşteri Girişi" tıkla
2. `customer/login.html` → Giriş yap
3. `customer/discover.html` → İşletme ara
4. "Randevu Al" → Wizard'ı tamamla
5. `customer/appointments.html` → QR kodunu gör

### Çalışan Akışı
1. `public/index.html` → "İşletme Girişi" (manuel: employee/dashboard.html)
2. Günlük randevuları gör
3. Randevu durumunu güncelle
4. QR kod ile müşteri check-in

### İşletme Akışı
1. `business/dashboard.html` → Ciro ve istatistikler
2. `business/dashboard-v2.html` → Randevuları yönet
3. `business/dashboard-v3.html` → Çalışanları görüntüle
4. `business/dashboard-v4.html` → Hizmetleri düzenle
5. `business/dashboard-v5.html` → Raporları incele

### Admin Akışı
1. `admin/dashboard.html` → Sistem durumu
2. `admin/dashboard-v2.html` → İşletmeleri yönet
3. `admin/dashboard-v3.html` → Kullanıcıları kontrol et
4. `admin/dashboard-v4.html` → Ödemeleri takip et
5. `admin/dashboard-v5.html` → Sistem ayarları

---

## 📱 Alt Navigasyon (Bottom Nav)

### Müşteri
- 🔍 **Keşfet** → `discover.html`
- 📅 **Randevularım** → `appointments.html`
- 👤 **Profil** → (Henüz yok)

### Çalışan
- 🏠 **Ana Sayfa** → `dashboard.html`
- 📊 **İstatistikler** → (Aynı sayfa scroll)
- ⚙️ **Ayarlar** → (Henüz yok)

---

**Not:** Profil, Ayarlar ve diğer yardımcı sayfalar henüz geliştirilmemiştir. Şu an sadece ana flow sayfaları mevcuttur.
