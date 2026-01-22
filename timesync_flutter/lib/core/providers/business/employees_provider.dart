import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeModel {
  final String id;
  final String name;
  final String role;
  final String photoUrl;
  final double rating;
  final int totalAppointments;
  final double totalRevenue;
  final bool isActive;
  final String workingHours;

  const EmployeeModel({
    required this.id,
    required this.name,
    required this.role,
    required this.photoUrl,
    required this.rating,
    required this.totalAppointments,
    required this.totalRevenue,
    required this.isActive,
    required this.workingHours,
  });
}

class BusinessEmployeesNotifier
    extends StateNotifier<AsyncValue<List<EmployeeModel>>> {
  BusinessEmployeesNotifier() : super(const AsyncValue.loading()) {
    loadEmployees();
  }

  Future<void> loadEmployees() async {
    state = const AsyncValue.loading();

    try {
      await Future.delayed(const Duration(milliseconds: 600));

      final employees = _generateMockEmployees();
      state = AsyncValue.data(employees);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> toggleEmployeeStatus(String employeeId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      state.whenData((employees) {
        final updatedEmployees = employees.map((emp) {
          if (emp.id == employeeId) {
            return EmployeeModel(
              id: emp.id,
              name: emp.name,
              role: emp.role,
              photoUrl: emp.photoUrl,
              rating: emp.rating,
              totalAppointments: emp.totalAppointments,
              totalRevenue: emp.totalRevenue,
              isActive: !emp.isActive,
              workingHours: emp.workingHours,
            );
          }
          return emp;
        }).toList();

        state = AsyncValue.data(updatedEmployees);
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  List<EmployeeModel> _generateMockEmployees() {
    return const [
      EmployeeModel(
        id: 'emp1',
        name: 'Mehmet Demir',
        role: 'Kuaför',
        photoUrl: 'https://ui-avatars.com/api/?name=Mehmet+Demir',
        rating: 4.9,
        totalAppointments: 342,
        totalRevenue: 18500,
        isActive: true,
        workingHours: '09:00 - 18:00',
      ),
      EmployeeModel(
        id: 'emp2',
        name: 'Ayşe Kaya',
        role: 'Güzellik Uzmanı',
        photoUrl: 'https://ui-avatars.com/api/?name=Ayse+Kaya',
        rating: 4.7,
        totalAppointments: 256,
        totalRevenue: 12800,
        isActive: true,
        workingHours: '10:00 - 19:00',
      ),
      EmployeeModel(
        id: 'emp3',
        name: 'Ali Yılmaz',
        role: 'Berber',
        photoUrl: 'https://ui-avatars.com/api/?name=Ali+Yilmaz',
        rating: 4.8,
        totalAppointments: 298,
        totalRevenue: 15200,
        isActive: true,
        workingHours: '09:00 - 17:00',
      ),
    ];
  }
}

final businessEmployeesProvider = StateNotifierProvider<
    BusinessEmployeesNotifier, AsyncValue<List<EmployeeModel>>>(
  (ref) => BusinessEmployeesNotifier(),
);
