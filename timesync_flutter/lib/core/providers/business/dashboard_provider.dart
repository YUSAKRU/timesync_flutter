import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusinessDashboardStats {
  final double todayRevenue;
  final double weekRevenue;
  final double monthRevenue;
  final int todayAppointments;
  final int todayCustomers;
  final int completionRate;
  final double revenueChangeToday;
  final double revenueChangeWeek;
  final double revenueChangeMonth;

  const BusinessDashboardStats({
    this.todayRevenue = 0,
    this.weekRevenue = 0,
    this.monthRevenue = 0,
    this.todayAppointments = 0,
    this.todayCustomers = 0,
    this.completionRate = 0,
    this.revenueChangeToday = 0,
    this.revenueChangeWeek = 0,
    this.revenueChangeMonth = 0,
  });
}

class BusinessDashboardNotifier
    extends StateNotifier<AsyncValue<BusinessDashboardStats>> {
  BusinessDashboardNotifier() : super(const AsyncValue.loading()) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = const AsyncValue.loading();

    try {
      await Future.delayed(const Duration(milliseconds: 800));

      const stats = BusinessDashboardStats(
        todayRevenue: 2450,
        weekRevenue: 14280,
        monthRevenue: 52150,
        todayAppointments: 24,
        todayCustomers: 18,
        completionRate: 92,
        revenueChangeToday: 12.5,
        revenueChangeWeek: 8.3,
        revenueChangeMonth: -3.2,
      );

      state = AsyncValue.data(stats);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    await loadDashboardData();
  }
}

final businessDashboardProvider = StateNotifierProvider<
    BusinessDashboardNotifier, AsyncValue<BusinessDashboardStats>>(
  (ref) => BusinessDashboardNotifier(),
);
