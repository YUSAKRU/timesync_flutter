import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/providers/customer/booking_provider.dart';
import '../../../data/models/service_model.dart';
import 'time_selection_screen.dart';

class ServiceSelectionScreen extends ConsumerStatefulWidget {
  final String businessId;
  final String businessName;

  const ServiceSelectionScreen({
    super.key,
    required this.businessId,
    required this.businessName,
  });

  @override
  ConsumerState<ServiceSelectionScreen> createState() => _ServiceSelectionScreenState();
}

class _ServiceSelectionScreenState extends ConsumerState<ServiceSelectionScreen> {
  // Mock services - in real app, fetch from provider
  final List<ServiceModel> _services = [
    const ServiceModel(
      id: 'srv1',
      businessId: 'biz1',
      name: 'Saç Kesimi',
      category: 'Kuaför',
      duration: 45,
      price: 150,
    ),
    const ServiceModel(
      id: 'srv2',
      businessId: 'biz1',
      name: 'Sakal Tıraşı',
      category: 'Berber',
      duration: 30,
      price: 80,
    ),
    const ServiceModel(
      id: 'srv3',
      businessId: 'biz1',
      name: 'Saç + Sakal',
      category: 'Berber',
      duration: 60,
      price: 200,
    ),
    const ServiceModel(
      id: 'srv4',
      businessId: 'biz1',
      name: 'Cilt Bakımı',
      category: 'Güzellik',
      duration: 45,
      price: 180,
    ),
    const ServiceModel(
      id: 'srv5',
      businessId: 'biz1',
      name: 'Manikür',
      category: 'Güzellik',
      duration: 30,
      price: 100,
    ),
    const ServiceModel(
      id: 'srv6',
      businessId: 'biz1',
      name: 'Pedikür',
      category: 'Güzellik',
      duration: 45,
      price: 120,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize booking with business info
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bookingProvider.notifier).initBooking(
            widget.businessId,
            widget.businessName,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingProvider);
    final selectedServices = bookingState.selectedServices;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: Text(
          'Hizmet Seçimi',
          style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  widget.businessName,
                  style: AppTextStyles.h3.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Almak istediğiniz hizmeti seçin',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 24),
                ..._services.map((service) => _buildServiceCard(service, selectedServices)),
              ],
            ),
          ),
          if (selectedServices.isNotEmpty) _buildBottomBar(context, bookingState),
        ],
      ),
    );
  }

  Widget _buildServiceCard(ServiceModel service, List<ServiceModel> selectedServices) {
    final isSelected = selectedServices.any((s) => s.id == service.id);

    return GestureDetector(
      onTap: () {
        ref.read(bookingProvider.notifier).toggleService(service);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : Colors.white.withOpacity(0.05),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey[600]!,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: AppColors.darkBackground,
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        '${service.duration} dk',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              '₺${service.price.toStringAsFixed(0)}',
              style: AppTextStyles.h4.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, BookingState bookingState) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.05),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${bookingState.selectedServices.length} Hizmet',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${bookingState.totalDuration} dk • ₺${bookingState.totalPrice.toStringAsFixed(0)}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TimeSelectionScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.darkBackground,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Devam Et',
                        style: AppTextStyles.button.copyWith(
                          color: AppColors.darkBackground,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.darkBackground,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
