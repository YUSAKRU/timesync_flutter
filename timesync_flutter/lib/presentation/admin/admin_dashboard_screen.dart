import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/providers/admin/dashboard_provider.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(adminDashboardProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: dashboardAsync.when(
          data: (stats) => RefreshIndicator(
            onRefresh: () async {
              await ref.read(adminDashboardProvider.notifier).loadDashboardData();
            },
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildStatsGrid(stats),
                const SizedBox(height: 24),
                _buildRevenueChart(),
                const SizedBox(height: 24),
                _buildRecentActivities(),
              ],
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.grey[600],
                ),
                const SizedBox(height: 16),
                Text(
                  'Dashboard yüklenemedi',
                  style: AppTextStyles.h4.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    ref.read(adminDashboardProvider.notifier).loadDashboardData();
                  },
                  child: const Text('Tekrar Dene'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sistem Yönetimi',
          style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'TimeSync Super Admin Panel',
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(AdminDashboardStats stats) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(
          title: 'Toplam İşletme',
          value: _formatNumber(stats.totalBusinesses),
          change: '${stats.businessesChange >= 0 ? '+' : ''}${stats.businessesChange.toStringAsFixed(1)}%',
          isPositive: stats.businessesChange >= 0,
          icon: Icons.business,
          color: AppColors.accentPurple,
        ),
        _buildStatCard(
          title: 'Toplam Kullanıcı',
          value: _formatNumber(stats.totalUsers),
          change: '${stats.usersChange >= 0 ? '+' : ''}${stats.usersChange.toStringAsFixed(1)}%',
          isPositive: stats.usersChange >= 0,
          icon: Icons.people,
          color: AppColors.primary,
        ),
        _buildStatCard(
          title: 'Toplam Gelir',
          value: '₺${_formatCurrency(stats.totalRevenue)}',
          change: '${stats.revenueChange >= 0 ? '+' : ''}${stats.revenueChange.toStringAsFixed(1)}%',
          isPositive: stats.revenueChange >= 0,
          icon: Icons.payments,
          color: AppColors.accentOrange,
        ),
        _buildStatCard(
          title: 'Aktif Abonelik',
          value: _formatNumber(stats.activeSubscriptions),
          change: '${stats.subscriptionsChange >= 0 ? '+' : ''}${stats.subscriptionsChange.toStringAsFixed(1)}%',
          isPositive: stats.subscriptionsChange >= 0,
          icon: Icons.workspace_premium,
          color: Colors.blue,
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(number % 1000 == 0 ? 0 : 1)}K';
    }
    return number.toString();
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}K';
    }
    return amount.toStringAsFixed(0);
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String change,
    required bool isPositive,
    required IconData icon,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive
                      ? Colors.green.withOpacity(0.15)
                      : Colors.red.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  change,
                  style: AppTextStyles.caption.copyWith(
                    color: isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: AppTextStyles.h3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    return Container(
      padding: const EdgeInsets.all(20),
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
          Text(
            'Gelir Özeti',
            style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                final heights = [120.0, 150.0, 100.0, 180.0, 140.0, 160.0, 190.0];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 32,
                      height: heights[index],
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primary,
                            AppColors.primary.withOpacity(0.5),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ['Pzt', 'Sal', 'Çrş', 'Prş', 'Cum', 'Cmt', 'Paz'][index],
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
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
              'Son Aktiviteler',
              style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _buildActivityItem(
            icon: Icons.business,
            iconColor: AppColors.accentPurple,
            title: 'Yeni işletme kaydı',
            subtitle: 'Makas Sanat - İstanbul, Kadıköy',
            time: '5 dk önce',
          ),
          const Divider(height: 1, indent: 60),
          _buildActivityItem(
            icon: Icons.payment,
            iconColor: AppColors.accentOrange,
            title: 'Abonelik ödemesi alındı',
            subtitle: 'Beauty Center - Premium Plan (₺499)',
            time: '15 dk önce',
          ),
          const Divider(height: 1, indent: 60),
          _buildActivityItem(
            icon: Icons.person_add,
            iconColor: AppColors.primary,
            title: 'Yeni kullanıcı kaydı',
            subtitle: 'Ahmet Yılmaz - Müşteri',
            time: '28 dk önce',
          ),
          const Divider(height: 1, indent: 60),
          _buildActivityItem(
            icon: Icons.error_outline,
            iconColor: Colors.red,
            title: 'Sistem hatası bildirildi',
            subtitle: 'Error #1245 - Payment Gateway',
            time: '1 saat önce',
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: AppTextStyles.caption.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
