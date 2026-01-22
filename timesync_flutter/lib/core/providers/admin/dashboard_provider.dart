import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminDashboardStats {
  final int totalBusinesses;
  final int totalUsers;
  final double totalRevenue;
  final int activeSubscriptions;
  final double businessesChange;
  final double usersChange;
  final double revenueChange;
  final double subscriptionsChange;

  const AdminDashboardStats({
    this.totalBusinesses = 0,
    this.totalUsers = 0,
    this.totalRevenue = 0,
    this.activeSubscriptions = 0,
    this.businessesChange = 0,
    this.usersChange = 0,
    this.revenueChange = 0,
    this.subscriptionsChange = 0,
  });
}

class AdminDashboardNotifier
    extends StateNotifier<AsyncValue<AdminDashboardStats>> {
  AdminDashboardNotifier() : super(const AsyncValue.loading()) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = const AsyncValue.loading();

    try {
      await Future.delayed(const Duration(milliseconds: 800));

      const stats = AdminDashboardStats(
        totalBusinesses: 1247,
        totalUsers: 45892,
        totalRevenue: 842000,
        activeSubscriptions: 982,
        businessesChange: 12.5,
        usersChange: 8.3,
        revenueChange: 15.2,
        subscriptionsChange: -2.1,
      );

      state = AsyncValue.data(stats);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final adminDashboardProvider = StateNotifierProvider<AdminDashboardNotifier,
    AsyncValue<AdminDashboardStats>>(
  (ref) => AdminDashboardNotifier(),
);
