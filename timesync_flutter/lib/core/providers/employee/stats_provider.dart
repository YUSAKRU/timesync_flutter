import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeStatsState {
  final int todayAppointments;
  final int weeklyAppointments;
  final double todayRevenue;
  final double weeklyRevenue;
  final double monthlyRevenue;
  final double rating;
  final int totalReviews;
  final int completionRate;

  const EmployeeStatsState({
    this.todayAppointments = 0,
    this.weeklyAppointments = 0,
    this.todayRevenue = 0,
    this.weeklyRevenue = 0,
    this.monthlyRevenue = 0,
    this.rating = 0,
    this.totalReviews = 0,
    this.completionRate = 0,
  });
}

class EmployeeStatsNotifier extends StateNotifier<AsyncValue<EmployeeStatsState>> {
  EmployeeStatsNotifier() : super(const AsyncValue.loading()) {
    loadStats();
  }

  Future<void> loadStats() async {
    state = const AsyncValue.loading();

    try {
      await Future.delayed(const Duration(milliseconds: 600));

      // Mock stats
      const stats = EmployeeStatsState(
        todayAppointments: 8,
        weeklyAppointments: 32,
        todayRevenue: 1240,
        weeklyRevenue: 4850,
        monthlyRevenue: 18500,
        rating: 4.8,
        totalReviews: 156,
        completionRate: 94,
      );

      state = AsyncValue.data(stats);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final employeeStatsProvider =
    StateNotifierProvider<EmployeeStatsNotifier, AsyncValue<EmployeeStatsState>>(
  (ref) => EmployeeStatsNotifier(),
);
