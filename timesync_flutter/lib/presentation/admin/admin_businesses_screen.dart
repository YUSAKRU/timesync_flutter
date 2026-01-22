import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class AdminBusinessesScreen extends ConsumerStatefulWidget {
  const AdminBusinessesScreen({super.key});

  @override
  ConsumerState<AdminBusinessesScreen> createState() => _AdminBusinessesScreenState();
}

class _AdminBusinessesScreenState extends ConsumerState<AdminBusinessesScreen> {
  String _selectedFilter = 'all'; // all, active, pending, suspended

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildFilterTabs(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildBusinessCard(
                    name: 'Makas Sanat',
                    category: 'Kuaför & Berber',
                    location: 'İstanbul, Kadıköy',
                    revenue: '₺52.1K',
                    appointments: 342,
                    rating: 4.8,
                    status: 'active',
                    subscriptionPlan: 'Premium Pro',
                  ),
                  const SizedBox(height: 12),
                  _buildBusinessCard(
                    name: 'Beauty Center',
                    category: 'Güzellik Salonu',
                    location: 'Ankara, Çankaya',
                    revenue: '₺38.5K',
                    appointments: 256,
                    rating: 4.6,
                    status: 'active',
                    subscriptionPlan: 'Premium',
                  ),
                  const SizedBox(height: 12),
                  _buildBusinessCard(
                    name: 'Spa Wellness',
                    category: 'Spa & Masaj',
                    location: 'İzmir, Alsancak',
                    revenue: '₺24.2K',
                    appointments: 189,
                    rating: 4.9,
                    status: 'pending',
                    subscriptionPlan: 'Temel',
                  ),
                  const SizedBox(height: 12),
                  _buildBusinessCard(
                    name: 'Nail Art Studio',
                    category: 'Tırnak Salonu',
                    location: 'Bursa, Nilüfer',
                    revenue: '₺15.8K',
                    appointments: 124,
                    rating: 4.5,
                    status: 'active',
                    subscriptionPlan: 'Premium',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            'İşletmeler',
            style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip('all', 'Tümü', '1,247'),
          const SizedBox(width: 12),
          _buildFilterChip('active', 'Aktif', '982'),
          const SizedBox(width: 12),
          _buildFilterChip('pending', 'Beklemede', '45'),
          const SizedBox(width: 12),
          _buildFilterChip('suspended', 'Askıda', '12'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String filter, String label, String count) {
    final isSelected = _selectedFilter == filter;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = filter),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.15)
              : AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : Colors.white.withOpacity(0.05),
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isSelected ? AppColors.primary : Colors.grey[300],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.2)
                    : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                count,
                style: AppTextStyles.caption.copyWith(
                  color: isSelected ? AppColors.primary : Colors.grey[400],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessCard({
    required String name,
    required String category,
    required String location,
    required String revenue,
    required int appointments,
    required double rating,
    required String status,
    required String subscriptionPlan,
  }) {
    Color statusColor;
    String statusText;
    
    switch (status) {
      case 'active':
        statusColor = Colors.green;
        statusText = 'Aktif';
        break;
      case 'pending':
        statusColor = Colors.orange;
        statusText = 'Beklemede';
        break;
      case 'suspended':
        statusColor = Colors.red;
        statusText = 'Askıda';
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'Bilinmiyor';
    }

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
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1585747860715-2ba37e788b70',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            statusText,
                            style: AppTextStyles.caption.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          location,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.02),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatItem('Gelir', revenue, Icons.payments),
                ),
                Container(width: 1, height: 30, color: Colors.white.withOpacity(0.1)),
                Expanded(
                  child: _buildStatItem('Randevular', '$appointments', Icons.event),
                ),
                Container(width: 1, height: 30, color: Colors.white.withOpacity(0.1)),
                Expanded(
                  child: _buildStatItem('Puan', '$rating', Icons.star),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.workspace_premium, size: 16, color: AppColors.accentPurple),
              const SizedBox(width: 6),
              Text(
                subscriptionPlan,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.accentPurple,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('Detay'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }
}
