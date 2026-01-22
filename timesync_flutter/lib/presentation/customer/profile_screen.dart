import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: ListView(
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildStatsCards(),
            const SizedBox(height: 24),
            _buildMenuSection(context),
            const SizedBox(height: 24),
            _buildLogoutButton(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 3,
                  ),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuAsYkyxwAOw5ioHq3gtXl0Ic5KSBbDisOHy4SI2rRON9dn9NfqC4vu1yb2aHyq5ozA6SPH1rwPeFyLhrdGSdpW8FaVVOP34pNLuEiTJw9pBnil8oEUDEXxbs_aPmTE5DQkIJy7CzyJFoYpwyTE1xVBhnpoHxyT22WYzj0UBATP7F5GjGLb-Lz-queuEO6A2lnTAg05A4coJOo53ZMloVLW9V_hYjFGZLfWmGeq1AU5UdW-Nxlu3OZue5dHI57nXPDL4sFXFfrGbjnQ',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.backgroundDark,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.edit,
                    color: AppColors.darkBackground,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Burak Yılmaz',
            style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'burak@example.com',
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              icon: Icons.calendar_today,
              value: '12',
              label: 'Randevu',
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              icon: Icons.favorite,
              value: '5',
              label: 'Favoriler',
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              icon: Icons.star,
              value: '24',
              label: 'Puan',
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.h3.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.05),
          ),
        ),
        child: Column(
          children: [
            _buildMenuItem(
              icon: Icons.person_outline,
              title: 'Profil Bilgileri',
              onTap: () {},
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.notifications_none,
              title: 'Bildirimler',
              onTap: () {},
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.payment_outlined,
              title: 'Ödeme Yöntemleri',
              onTap: () {},
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.language_outlined,
              title: 'Dil Seçimi',
              trailing: 'Türkçe',
              onTap: () {},
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.dark_mode_outlined,
              title: 'Karanlık Mod',
              showSwitch: true,
              onTap: null,
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.help_outline,
              title: 'Yardım & Destek',
              onTap: () {},
            ),
            _buildDivider(),
            _buildMenuItem(
              icon: Icons.privacy_tip_outlined,
              title: 'Gizlilik Politikası',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? trailing,
    bool showSwitch = false,
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
      trailing: showSwitch
          ? Switch(
              value: true,
              onChanged: (value) {},
              activeColor: AppColors.primary,
            )
          : trailing != null
              ? Text(
                  trailing,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.grey[400],
                  ),
                )
              : trailing == null && onTap != null
                  ? Icon(Icons.chevron_right, color: Colors.grey[600])
                  : null,
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.white.withOpacity(0.05),
      indent: 60,
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: OutlinedButton(
        onPressed: () {
          // TODO: Logout logic
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.red.withOpacity(0.5)),
          foregroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout),
            const SizedBox(width: 8),
            Text(
              'Çıkış Yap',
              style: AppTextStyles.button.copyWith(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
