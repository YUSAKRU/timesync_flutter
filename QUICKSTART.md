# 🚀 TimeSync - Hızlı Başlangıç Rehberi

## 📦 1. Projeyi Başlatma

### Seçenek A: VS Code Live Server (Önerilen)
1. VS Code'da projeyi açın
2. `public/index.html` dosyasına sağ tıklayın
3. "Open with Live Server" seçeneğini tıklayın
4. Tarayıcınızda otomatik olarak açılacaktır

### Seçenek B: Python HTTP Server
\`\`\`bash
cd timeSync/public
python3 -m http.server 8000
# Tarayıcıda: http://localhost:8000
\`\`\`

### Seçenek C: Node.js HTTP Server
\`\`\`bash
cd timeSync/public
npx http-server -p 8000
# Tarayıcıda: http://localhost:8000
\`\`\`

## 🎯 2. İlk Adımlar

### Ana Sayfayı Keşfet
1. `http://localhost:8000/index.html` adresini açın
2. Karşınıza 2 seçenek çıkacak:
   - **Müşteri Girişi** → Randevu almak isteyenler için
   - **İşletme Girişi** → Randevu sağlayan işletmeler için

## 👤 3. Müşteri Olarak Gezin

### Adım 1: Giriş Yap
- Ana sayfadan "Müşteri Girişi" kartına tıklayın
- Veya: `src/pages/customer/login.html` dosyasını açın

### Adım 2: İşletmeleri Keşfet
- Giriş yaptıktan sonra `discover.html` sayfası açılır
- Arama çubuğunu kullanın
- Kategorilere göre filtreleyin: Kuaför, Dişçi, Spa, Diyetisyen
- İşletme kartlarını inceleyin

### Adım 3: Randevu Al
- Bir işletmenin "Randevu Al" butonuna tıklayın
- Bottom sheet açılacak:
  1. **Hizmet seçin** (Saç kesimi, Sakal tıraşı, vb.)
  2. **Personel seçin** (Ahmet Usta, Mehmet Bey, vb.)
  3. **Tarih ve saat seçin**
  4. "Onayla ve Öde" butonuna tıklayın

### Adım 4: Randevularınızı Görüntüleyin
- Alt menüden "Randevularım" sekmesine gidin
- Veya: `appointments.html` dosyasını açın
- QR kodunu görüntüleyin
- "Yol Tarifi" veya "İptal Et" butonlarını kullanın

## 💼 4. İşletme Olarak Gezin

### Dashboard'u Aç
- `src/pages/business/dashboard.html` dosyasını açın
- Veya ana sayfadan "İşletme Girişi" kartına tıklayın

### Özellikleri İncele
1. **Genel Bakış** (dashboard.html)
   - Bugünkü ciro
   - Randevu sayısı
   - Müşteri istatistikleri

2. **Randevular** (dashboard-v2.html)
   - Günlük randevu listesi
   - Durum güncelleme

3. **Çalışanlar** (dashboard-v3.html)
   - Personel listesi
   - Performans metrikleri

4. **Hizmetler** (dashboard-v4.html)
   - Sunulan hizmetler
   - Fiyatlandırma

5. **Raporlar** (dashboard-v5.html)
   - Gelir grafikleri
   - Analitik veriler

## 👨‍💼 5. Çalışan Olarak Gezin

### Dashboard'u Aç
- `src/pages/employee/dashboard.html` dosyasını açın

### Günlük İş Akışı
1. Bugünkü performansı gör (8 randevu, 2 tamamlandı)
2. Timeline'da randevuları incele
3. Randevu kartlarında:
   - Müşteri bilgisi
   - Hizmet detayı
   - Başlangıç saati
4. Durum güncellemeleri yap:
   - ⏰ Bekliyor
   - 🚀 Başladı
   - ✅ Tamamlandı
5. QR kod ile müşteri check-in

### Varyantları Dene
- `dashboard-v2.html` → Farklı layout
- `dashboard-v3.html` → Alternatif görünüm

## 🔐 6. Admin Olarak Gezin

### Admin Panelini Aç
- `src/pages/admin/dashboard.html` dosyasını açın

### Sistem Yönetimi
1. **Genel Bakış** (dashboard.html)
   - Toplam gelir: 1.2M ₺
   - Aktif işletme: 145
   - Platform istatistikleri

2. **İşletmeler** (dashboard-v2.html)
   - İşletme listesi
   - Durum kontrolü
   - Abonelik bilgileri

3. **Kullanıcılar** (dashboard-v3.html)
   - Kullanıcı yönetimi
   - Aktivite logları

4. **Ödemeler** (dashboard-v4.html)
   - Ödeme takibi
   - Finansal raporlar

5. **Ayarlar** (dashboard-v5.html)
   - Sistem konfigürasyonu
   - Email/SMS ayarları

## 🎨 7. Dark Mode

### Tema Değiştirme
- Sayfalarda genellikle dark mode aktiftir
- Light mode için HTML tag'ındaki `class="dark"` ifadesini kaldırın
- Veya JavaScript Console'da:
\`\`\`javascript
document.documentElement.classList.remove('dark'); // Light mode
document.documentElement.classList.add('dark');    // Dark mode
\`\`\`

## 🔧 8. Özelleştirme

### Renkleri Değiştir
`src/assets/js/tailwind-config.js` dosyasını düzenleyin:
\`\`\`javascript
colors: {
    "primary": "#36e27b",      // Ana renk
    "primary-dark": "#2ab561",  // Koyu ton
    // ...
}
\`\`\`

### Stilleri Özelleştir
`src/assets/css/common.css` dosyasına kendi stillerinizi ekleyin.

## 📝 9. Test Senaryoları

### Müşteri Test Akışı
\`\`\`
1. index.html → Müşteri Kartı
2. login.html → Email/Şifre gir (mock)
3. discover.html → "Makas Sanat" ara
4. "Randevu Al" → Wizard'ı tamamla
5. appointments.html → QR kodu kontrol et
\`\`\`

### İşletme Test Akışı
\`\`\`
1. business/dashboard.html → Ciro: 4.250₺
2. dashboard-v2.html → Bugünün randevuları
3. dashboard-v3.html → 5 çalışan gör
4. dashboard-v4.html → 12 hizmet listele
5. dashboard-v5.html → Aylık rapor incele
\`\`\`

### Çalışan Test Akışı
\`\`\`
1. employee/dashboard.html → 8 randevu bekliyor
2. Timeline'da saat 14:00 → "Ahmet Yılmaz"
3. "Başladı" butonuna tıkla
4. Hizmeti tamamla → "Tamamlandı"
5. QR kod oku (görsel)
\`\`\`

## 🐛 10. Sorun Giderme

### Sayfa Açılmıyor
- Dosya yollarını kontrol edin
- Console'da hata var mı bakın (F12)
- Live Server'ı yeniden başlatın

### Stiller Yüklenmedi
- Tailwind CDN linkini kontrol edin
- `common.css` dosyasının yüklendiğini doğrulayın
- Tarayıcı cache'ini temizleyin (Ctrl+Shift+R)

### Dark Mode Çalışmıyor
- HTML tag'ında `class="dark"` olduğunu kontrol edin
- `tailwind-config.js` dosyasının yüklendiğini kontrol edin

### İkonlar Görünmüyor
- Google Fonts Material Symbols linkini kontrol edin
- İnternet bağlantınızı kontrol edin

## 📚 11. Sonraki Adımlar

### Backend Entegrasyonu İçin Hazırlık
1. `src/assets/js/common.js` içindeki `apiCall()` fonksiyonunu inceleyin
2. Mock data yerine gerçek API endpoint'leri ekleyin
3. Authentication sistemi entegre edin

### Component Sistemi
1. `src/components/` klasörüne tekrar kullanılabilir bileşenler ekleyin
2. Navbar, Modal, Card gibi component'leri ayırın
3. JavaScript modüller kullanın

### State Management
1. localStorage ile basit state management
2. Daha kompleks için: Redux, MobX, Zustand
3. Form verilerini yönetin

## 💡 12. İpuçları

### Geliştirme İpuçları
- **VS Code Extensions:**
  - Live Server
  - Tailwind CSS IntelliSense
  - Auto Rename Tag
  - Prettier

- **Tarayıcı DevTools:**
  - Responsive mod (Ctrl+Shift+M)
  - Console (F12)
  - Network tab (API çağrıları için)

### Performans İpuçları
- Resimleri optimize edin
- Tailwind JIT mode kullanın
- CSS/JS dosyalarını minify edin

## 🎓 13. Öğrenme Kaynakları

### Tailwind CSS
- Resmi Dokümantasyon: https://tailwindcss.com
- Tailwind UI: https://tailwindui.com

### Material Design
- Material Symbols: https://fonts.google.com/icons
- Material Design 3: https://m3.material.io

## 📞 14. Yardım

### Sık Sorulan Sorular
**S: Sayfalar arası nasıl geçiş yapabilirim?**
C: HTML dosyalarını doğrudan açın veya link'leri kullanın.

**S: Backend olmadan nasıl test edeceğim?**
C: Mock data kullanın, `common.js` içindeki fonksiyonlar yardımcı olacaktır.

**S: Mobile görünümü nasıl test ederim?**
C: Browser DevTools → Responsive mode (Ctrl+Shift+M)

---

## ✅ Kontrol Listesi

Başlamadan önce:
- [ ] Proje klasörünü açtım
- [ ] Live Server veya HTTP server kurdum
- [ ] Tarayıcımda test ettim
- [ ] Dark mode çalışıyor
- [ ] Tüm sayfalar yükleniyor
- [ ] Console'da hata yok

Hazırsınız! 🎉

---

**Keyifli Geliştirmeler! 🚀**
