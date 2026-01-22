import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class BusinessServicesScreen extends ConsumerWidget {
  const BusinessServicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildAddServiceCard(context),
                  const SizedBox(height: 20),
                  Text(
                    'Hizmetler',
                    style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildServiceCard(
                    name: 'Saç Kesimi',
                    category: 'Saç',
                    price: '₺150',
                    duration: '45 dk',
                    isActive: true,
                    totalBookings: 156,
                  ),
                  const SizedBox(height: 12),
                  _buildServiceCard(
                    name: 'Sakal Tıraşı',
                    category: 'Sakal',
                    price: '₺80',
                    duration: '30 dk',
                    isActive: true,
                    totalBookings: 98,
                  ),
                  const SizedBox(height: 12),
                  _buildServiceCard(
                    name: 'Saç + Sakal',
                    category: 'Paket',
                    price: '₺200',
                    duration: '60 dk',
                    isActive: true,
                    totalBookings: 124,
                  ),
                  const SizedBox(height: 12),
                  _buildServiceCard(
                    name: 'Cilt Bakımı',
                    category: 'Bakım',
                    price: '₺180',
                    duration: '45 dk',
                    isActive: true,
                    totalBookings: 67,
                  ),
                  const SizedBox(height: 12),
                  _buildServiceCard(
                    name: 'Manikür',
                    category: 'Tırnak',
                    price: '₺100',
                    duration: '30 dk',
                    isActive: false,
                    totalBookings: 45,
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
            'Hizmetler',
            style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAddServiceCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Add service dialog
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Yeni Hizmet Ekle',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Fiyat listesine yeni hizmet ekleyin',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required String name,
    required String category,
    required String price,
    required String duration,
    required bool isActive,
    required int totalBookings,
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
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.content_cut,
                  color: AppColors.primary,
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
                            color: isActive
                                ? Colors.green.withOpacity(0.15)
                                : Colors.grey.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            isActive ? 'Aktif' : 'Pasif',
                            style: AppTextStyles.caption.copyWith(
                              color: isActive ? Colors.green : Colors.grey,
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
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          duration,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.event_available, size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          '$totalBookings randevu',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fiyat',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      price,
                      style: AppTextStyles.h4.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, size: 18),
                label: const Text('Düzenle'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
