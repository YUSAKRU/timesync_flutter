import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/providers/employee/schedule_provider.dart';
import '../../data/models/appointment_model.dart';

class EmployeeScheduleScreen extends ConsumerStatefulWidget {
  const EmployeeScheduleScreen({super.key});

  @override
  ConsumerState<EmployeeScheduleScreen> createState() => _EmployeeScheduleScreenState();
}

class _EmployeeScheduleScreenState extends ConsumerState<EmployeeScheduleScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(employeeScheduleProvider.notifier).loadSchedule(date: _selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildDateSelector(),
            Expanded(
              child: _buildSchedule(),
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
            'Takvim',
            style: AppTextStyles.h2.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () => setState(() => _selectedDate = DateTime.now()),
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 30,
        itemBuilder: (context, index) {
          final date = DateTime.now().add(Duration(days: index - 3));
          final isSelected = DateFormat('dd/MM/yyyy').format(date) ==
              DateFormat('dd/MM/yyyy').format(_selectedDate);

          return GestureDetector(
            onTap: () {
              setState(() => _selectedDate = date);
              ref.read(employeeScheduleProvider.notifier).loadSchedule(date: date);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 70,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : Colors.white.withOpacity(0.05),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE', 'tr_TR').format(date),
                    style: AppTextStyles.caption.copyWith(
                      color: isSelected
                          ? AppColors.darkBackground
                          : Colors.grey[400],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('dd').format(date),
                    style: AppTextStyles.h3.copyWith(
                      color: isSelected
                          ? AppColors.darkBackground
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('MMM', 'tr_TR').format(date),
                    style: AppTextStyles.caption.copyWith(
                      color: isSelected
                          ? AppColors.darkBackground
                          : Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSchedule() {
    final scheduleAsync = ref.watch(employeeScheduleProvider);

    return scheduleAsync.when(
      data: (appointments) {
        if (appointments.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_available,
                  size: 64,
                  color: Colors.grey[600],
                ),
                const SizedBox(height: 16),
                Text(
                  'Bu tarihte randevu yok',
                  style: AppTextStyles.h4.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await ref.read(employeeScheduleProvider.notifier).loadSchedule(
              date: _selectedDate,
            );
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              return _buildTimeSlot(appointments[index]);
            },
          ),
        );
      },
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
              'Program yüklenemedi',
              style: AppTextStyles.h4.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                ref.read(employeeScheduleProvider.notifier).loadSchedule(
                  date: _selectedDate,
                );
              },
              child: const Text('Tekrar Dene'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlot(AppointmentModel appointment) {
    final statusInfo = _getStatusInfo(appointment.status);
    final timeFormat = DateFormat('HH:mm');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Text(
                  timeFormat.format(appointment.dateTime),
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${appointment.duration} dk',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.customerName,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  appointment.serviceNames.join(', '),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(statusInfo['icon'] as IconData, size: 14, color: statusInfo['color'] as Color),
                    const SizedBox(width: 4),
                    Text(
                      statusInfo['text'] as String,
                      style: AppTextStyles.caption.copyWith(
                        color: statusInfo['color'] as Color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (appointment.status == AppointmentStatus.confirmed)
            ElevatedButton(
              onPressed: () async {
                await ref.read(employeeScheduleProvider.notifier).updateAppointmentStatus(
                  appointment.id,
                  AppointmentStatus.completed,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Tamamla'),
            ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getStatusInfo(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.completed:
        return {
          'color': Colors.green,
          'icon': Icons.check_circle,
          'text': 'Tamamlandı',
        };
      case AppointmentStatus.confirmed:
        return {
          'color': Colors.orange,
          'icon': Icons.schedule,
          'text': 'Onaylandı',
        };
      case AppointmentStatus.pending:
        return {
          'color': Colors.blue,
          'icon': Icons.hourglass_empty,
          'text': 'Bekliyor',
        };
      case AppointmentStatus.cancelled:
        return {
          'color': Colors.red,
          'icon': Icons.cancel,
          'text': 'İptal Edildi',
        };
      case AppointmentStatus.noShow:
        return {
          'color': Colors.grey,
          'icon': Icons.person_off,
          'text': 'Gelmedi',
        };
    }
  }
}
