import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/providers/customer/appointments_provider.dart';
import '../../data/models/appointment_model.dart';
import 'package:intl/intl.dart';
import 'qr_code_screen.dart';

class AppointmentsScreen extends ConsumerStatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  ConsumerState<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends ConsumerState<AppointmentsScreen> {
  String _selectedTab = 'Yaklaşan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabs(),
            Expanded(
              child: _selectedTab == 'Yaklaşan'
                  ? _buildUpcomingAppointments()
                  : _buildPastAppointments(),
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
            'Randevularım',
            style: AppTextStyles.h2.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.grey[400]),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(child: _buildTab('Yaklaşan')),
            Expanded(child: _buildTab('Geçmiş')),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label) {
    final isSelected = _selectedTab == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isSelected ? AppColors.darkBackground : Colors.grey[400],
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingAppointments() {
    final appointmentsAsync = ref.watch(currentUserAppointmentsProvider);
    
    return appointmentsAsync.when(
      data: (_) {
        final upcomingAppointments = ref.watch(upcomingAppointmentsProvider);
        
        if (upcomingAppointments.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_busy,
                  size: 64,
                  color: Colors.grey[600],
                ),
                const SizedBox(height: 16),
                Text(
                  'Yaklaşan randevunuz yok',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          );
        }
        
        return RefreshIndicator(
          onRefresh: () async {
            await ref.read(currentUserAppointmentsProvider.notifier).loadAppointments();
          },
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: upcomingAppointments.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final appointment = upcomingAppointments[index];
              return _buildAppointmentCard(
                appointment: appointment,
                onCancel: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Randevuyu İptal Et'),
                      content: const Text(
                          'Randevuyu iptal etmek istediğinizden emin misiniz?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Vazgeç'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text(
                            'İptal Et',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                  
                  if (confirmed == true) {
                    await ref
                        .read(currentUserAppointmentsProvider.notifier)
                        .cancelAppointment(appointment.id);
                    
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Randevu iptal edildi'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  }
                },
              );
            },
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      error: (error, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Randevular yüklenemedi',
              style: AppTextStyles.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: AppTextStyles.bodySmall.copyWith(color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(currentUserAppointmentsProvider.notifier).loadAppointments();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text('Tekrar Dene'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPastAppointments() {
    final appointmentsAsync = ref.watch(currentUserAppointmentsProvider);
    
    return appointmentsAsync.when(
      data: (_) {
        final pastAppointments = ref.watch(pastAppointmentsProvider);
        
        if (pastAppointments.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.history,
                  size: 64,
                  color: Colors.grey[600],
                ),
                const SizedBox(height: 16),
                Text(
                  'Geçmiş randevu bulunmuyor',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          );
        }
        
        return RefreshIndicator(
          onRefresh: () async {
            await ref.read(currentUserAppointmentsProvider.notifier).loadAppointments();
          },
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: pastAppointments.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final appointment = pastAppointments[index];
              return _buildAppointmentCard(
                appointment: appointment,
                onCancel: null, // Geçmiş randevular iptal edilemez
              );
            },
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      error: (error, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Randevular yüklenemedi',
              style: AppTextStyles.bodyLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(currentUserAppointmentsProvider.notifier).loadAppointments();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text('Tekrar Dene'),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getStatusInfo(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.confirmed:
        return {
          'color': AppColors.primary,
          'text': 'Onaylandı',
          'icon': Icons.check_circle,
        };
      case AppointmentStatus.pending:
        return {
          'color': Colors.orange,
          'text': 'Beklemede',
          'icon': Icons.schedule,
        };
      case AppointmentStatus.completed:
        return {
          'color': Colors.blue,
          'text': 'Tamamlandı',
          'icon': Icons.done_all,
        };
      case AppointmentStatus.cancelled:
        return {
          'color': Colors.red,
          'text': 'İptal Edildi',
          'icon': Icons.cancel,
        };
      case AppointmentStatus.noShow:
        return {
          'color': Colors.grey,
          'text': 'Gelmedi',
          'icon': Icons.person_off,
        };
    }
  }

  Widget _buildAppointmentCard({
    required appointment,
    VoidCallback? onCancel,
  }) {
    final statusInfo = _getStatusInfo(appointment.status);
    final dateFormat = DateFormat('dd MMMM yyyy', 'tr_TR');
    final timeFormat = DateFormat('HH:mm');

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
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusInfo['color'].withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(statusInfo['icon'], color: statusInfo['color'], size: 14),
                    const SizedBox(width: 4),
                    Text(
                      statusInfo['text'],
                      style: AppTextStyles.caption.copyWith(
                        color: statusInfo['color'],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                '₺${appointment.totalPrice}',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            appointment.businessName,
            style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            appointment.serviceNames.join(', '),
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey[400]),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[500]),
              const SizedBox(width: 8),
              Text(
                dateFormat.format(appointment.dateTime),
                style: AppTextStyles.bodySmall.copyWith(color: Colors.grey[400]),
              ),
              const SizedBox(width: 16),
              Icon(Icons.access_time, size: 16, color: Colors.grey[500]),
              const SizedBox(width: 8),
              Text(
                timeFormat.format(appointment.dateTime),
                style: AppTextStyles.bodySmall.copyWith(color: Colors.grey[400]),
              ),
            ],
          ),
          if (onCancel != null && 
              appointment.status != AppointmentStatus.completed &&
              appointment.status != AppointmentStatus.cancelled) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red.withOpacity(0.5)),
                      foregroundColor: Colors.red,
                    ),
                    child: const Text('İptal Et'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QrCodeScreen(
                            appointment: appointment,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.qr_code, size: 18),
                    label: const Text('QR Kod'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.darkBackground,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
