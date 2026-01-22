import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class AdminSettingsScreen extends ConsumerWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Sistem Ayarları',
              style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildSystemSection(),
            const SizedBox(height: 24),
            _buildSecuritySection(),
            const SizedBox(height: 24),
            _buildNotificationsSection(),
            const SizedBox(height: 24),
            _buildMaintenanceSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Sistem Yapılandırması',
              style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _buildSettingsTile(
            icon: Icons.language,
            title: 'Varsayılan Dil',
            subtitle: 'Türkçe',
            onTap: () {},
          ),
          const Divider(height: 1, indent: 60),
          _buildSettingsTile(
            icon: Icons.payments,
            title: 'Ödeme Sistemi',
            subtitle: 'Stripe & PayPal Aktif',
            onTap: () {},
          ),
          const Divider(height: 1, indent: 60),
          _buildSettingsTile(
            icon: Icons.access_time,
            title: 'Zaman Dilimi',
            subtitle: 'UTC+3 (İstanbul)',
            onTap: () {},
          ),
          const Divider(height: 1, indent: 60),
          _buildSettingsTile(
            icon: Icons.cloud,
            title: 'Yedekleme',
            subtitle: 'Otomatik günlük yedekleme',
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Güvenlik',
              style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _buildSettingsTile(
            icon: Icons.security,
            title: 'İki Faktörlü Doğrulama',
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: AppColors.primary,
            ),
          ),
          const Divider(height: 1, indent: 60),
          _buildSettingsTile(
            icon: Icons.shield,
            title: 'Güvenlik Duvarı',
            subtitle: 'Aktif',
            trailing: const Icon(Icons.check_circle, color: Colors.green),
          ),
          const Divider(height: 1, indent: 60),
          _buildSettingsTile(
            icon: Icons.vpn_lock,
            title: 'SSL Sertifikası',
            subtitle: 'Geçerli - 15 Ocak 2026',
            onTap: () {},
          ),
          const Divider(height: 1, indent: 60),
          _buildSettingsTile(
            icon: Icons.history,
            title: 'Oturum Geçmişi',
            subtitle: 'Son 90 gün',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Bildirimler',
              style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _buildSettingsTile(
            icon: Icons.email,
            title: 'E-posta Bildirimleri',
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: AppColors.primary,
            ),
          ),
          const Divider(height: 1, indent: 60),
          _buildSettingsTile(
            icon: Icons.notifications_active,
            title: 'Push Bildirimler',
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: AppColors.primary,
            ),
          ),
          const Divider(height: 1, indent: 60),
          _buildSettingsTile(
            icon: Icons.error_outline,
            title: 'Hata Bildirimleri',
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange.withOpacity(0.2),
            Colors.orange.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.orange.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.construction, color: Colors.orange),
              const SizedBox(width: 12),
              Text(
                'Bakım Modu',
                style: AppTextStyles.h4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Sistem bakımı sırasında tüm kullanıcılar için hizmet geçici olarak durdurulacaktır.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.schedule),
                  label: const Text('Zamanla'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.orange,
                    side: const BorderSide(color: Colors.orange),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.power_settings_new),
                  label: const Text('Başlat'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[400]),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.grey[500],
              ),
            )
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    );
  }
}
