import 'dart:math';
import '../../models/employee_model.dart';
import '../result.dart';

/// Mock Employee Repository
/// Simulates API calls for employee management
class MockEmployeeRepository {
  final _random = Random();

  // Simulate network delay
  Future<void> _delay() async {
    await Future.delayed(Duration(milliseconds: 350 + _random.nextInt(650)));
  }

  /// Get employees by business ID
  Future<Result<List<EmployeeModel>>> getEmployeesByBusiness(
    String businessId, {
    bool? isActive,
  }) async {
    try {
      await _delay();

      var employees = _mockEmployees
          .where((e) => e.businessId == businessId)
          .toList();

      // Apply active filter
      if (isActive != null) {
        employees = employees.where((e) => e.isActive == isActive).toList();
      }

      // Sort by rating (highest first)
      employees.sort((a, b) => b.rating.compareTo(a.rating));

      return Result.success(employees);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get employee by ID
  Future<Result<EmployeeModel>> getEmployeeById(String id) async {
    try {
      await _delay();

      final employee = _mockEmployees.firstWhere(
        (e) => e.id == id,
        orElse: () => throw Exception('Çalışan bulunamadı'),
      );

      return Result.success(employee);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get top performing employees
  Future<Result<List<EmployeeModel>>> getTopEmployees({
    String? businessId,
    int limit = 5,
  }) async {
    try {
      await _delay();

      var employees = businessId != null
          ? _mockEmployees.where((e) => e.businessId == businessId).toList()
          : List<EmployeeModel>.from(_mockEmployees);

      // Sort by total revenue (highest first)
      employees.sort((a, b) => b.totalRevenue.compareTo(a.totalRevenue));

      return Result.success(employees.take(limit).toList());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Create new employee
  Future<Result<EmployeeModel>> createEmployee({
    required String businessId,
    required String userId,
    required String name,
    required String role,
    required String phone,
    required String email,
    List<String>? specialties,
  }) async {
    try {
      await _delay();

      final newEmployee = EmployeeModel(
        id: 'emp_${DateTime.now().millisecondsSinceEpoch}',
        businessId: businessId,
        userId: userId,
        name: name,
        role: role,
        phone: phone,
        email: email,
        rating: 5.0,
        totalAppointments: 0,
        totalRevenue: 0.0,
        isActive: true,
        specialties: specialties,
        createdAt: DateTime.now(),
      );

      return Result.success(newEmployee);
    } catch (e) {
      return Result.failure('Çalışan eklenemedi: ${e.toString()}');
    }
  }

  /// Update employee
  Future<Result<EmployeeModel>> updateEmployee({
    required String employeeId,
    String? name,
    String? role,
    String? phone,
    String? email,
    String? photoUrl,
    bool? isActive,
    String? workingHours,
    List<String>? specialties,
  }) async {
    try {
      await _delay();

      final employee = _mockEmployees.firstWhere(
        (e) => e.id == employeeId,
        orElse: () => throw Exception('Çalışan bulunamadı'),
      );

      final updatedEmployee = employee.copyWith(
        name: name ?? employee.name,
        role: role ?? employee.role,
        phone: phone ?? employee.phone,
        email: email ?? employee.email,
        photoUrl: photoUrl ?? employee.photoUrl,
        isActive: isActive ?? employee.isActive,
        workingHours: workingHours ?? employee.workingHours,
        specialties: specialties ?? employee.specialties,
      );

      return Result.success(updatedEmployee);
    } catch (e) {
      return Result.failure('Çalışan güncellenemedi: ${e.toString()}');
    }
  }

  /// Delete employee
  Future<Result<bool>> deleteEmployee(String employeeId) async {
    try {
      await _delay();

      final exists = _mockEmployees.any((e) => e.id == employeeId);
      if (!exists) {
        throw Exception('Çalışan bulunamadı');
      }

      return Result.success(true);
    } catch (e) {
      return Result.failure('Çalışan silinemedi: ${e.toString()}');
    }
  }

  // Mock employees
  final List<EmployeeModel> _mockEmployees = [
    EmployeeModel(
      id: 'emp1',
      businessId: 'biz1',
      userId: 'emp1',
      name: 'Mehmet Usta',
      role: 'Kuaför',
      phone: '+90 532 555 10 01',
      email: 'mehmet.usta@elite.com',
      photoUrl: 'https://i.pravatar.cc/150?img=13',
      rating: 4.9,
      totalAppointments: 1250,
      totalRevenue: 312500.0,
      isActive: true,
      workingHours: '09:00-18:00',
      specialties: ['Saç Kesimi', 'Saç Boyama', 'Sakal Tıraşı'],
      createdAt: DateTime.now().subtract(const Duration(days: 730)),
    ),
    EmployeeModel(
      id: 'emp2',
      businessId: 'biz2',
      userId: 'emp2',
      name: 'Zeynep Hanım',
      role: 'Güzellik Uzmanı',
      phone: '+90 532 555 10 02',
      email: 'zeynep@guzellik.com',
      photoUrl: 'https://i.pravatar.cc/150?img=9',
      rating: 4.8,
      totalAppointments: 980,
      totalRevenue: 343000.0,
      isActive: true,
      workingHours: '10:00-19:00',
      specialties: ['Manikür', 'Pedikür', 'Cilt Bakımı'],
      createdAt: DateTime.now().subtract(const Duration(days: 600)),
    ),
    EmployeeModel(
      id: 'emp3',
      businessId: 'biz3',
      userId: 'user5',
      name: 'Ali Masöz',
      role: 'Masaj Terapisti',
      phone: '+90 532 555 10 03',
      email: 'ali@spamerkezi.com',
      photoUrl: 'https://i.pravatar.cc/150?img=14',
      rating: 4.7,
      totalAppointments: 670,
      totalRevenue: 268000.0,
      isActive: true,
      workingHours: '11:00-20:00',
      specialties: ['Relax Masajı', 'Thai Masajı', 'Aromaterapi'],
      createdAt: DateTime.now().subtract(const Duration(days: 450)),
    ),
    EmployeeModel(
      id: 'emp4',
      businessId: 'biz4',
      userId: 'user6',
      name: 'Selin Hanım',
      role: 'Nail Artist',
      phone: '+90 532 555 10 04',
      email: 'selin@nailart.com',
      photoUrl: 'https://i.pravatar.cc/150?img=10',
      rating: 4.9,
      totalAppointments: 890,
      totalRevenue: 445000.0,
      isActive: true,
      workingHours: '10:00-19:00',
      specialties: ['Nail Art', 'Protez Tırnak', 'Manikür'],
      createdAt: DateTime.now().subtract(const Duration(days: 540)),
    ),
    EmployeeModel(
      id: 'emp5',
      businessId: 'biz5',
      userId: 'user7',
      name: 'Hasan Berber',
      role: 'Berber',
      phone: '+90 532 555 10 05',
      email: 'hasan@barbershop.com',
      photoUrl: 'https://i.pravatar.cc/150?img=15',
      rating: 4.6,
      totalAppointments: 1100,
      totalRevenue: 220000.0,
      isActive: true,
      workingHours: '09:00-18:00',
      specialties: ['Saç Kesimi', 'Sakal Tıraşı', 'Cilt Bakımı'],
      createdAt: DateTime.now().subtract(const Duration(days: 800)),
    ),
    EmployeeModel(
      id: 'emp6',
      businessId: 'biz6',
      userId: 'user8',
      name: 'Dr. Aylin',
      role: 'Cilt Bakım Uzmanı',
      phone: '+90 532 555 10 06',
      email: 'dr.aylin@ciltbakim.com',
      photoUrl: 'https://i.pravatar.cc/150?img=16',
      rating: 4.9,
      totalAppointments: 560,
      totalRevenue: 672000.0,
      isActive: true,
      workingHours: '10:00-18:00',
      specialties: ['Lazer Tedavisi', 'Botox', 'Dolgu'],
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
    ),
    EmployeeModel(
      id: 'emp7',
      businessId: 'biz7',
      userId: 'user9',
      name: 'Elif Öğretmen',
      role: 'Yoga Eğitmeni',
      phone: '+90 532 555 10 07',
      email: 'elif@yogastudio.com',
      photoUrl: 'https://i.pravatar.cc/150?img=17',
      rating: 4.8,
      totalAppointments: 450,
      totalRevenue: 90000.0,
      isActive: true,
      workingHours: '08:00-17:00',
      specialties: ['Hatha Yoga', 'Vinyasa', 'Meditasyon'],
      createdAt: DateTime.now().subtract(const Duration(days: 400)),
    ),
    EmployeeModel(
      id: 'emp8',
      businessId: 'biz1',
      userId: 'user10',
      name: 'Can Yardımcı',
      role: 'Kuaför Yardımcısı',
      phone: '+90 532 555 10 08',
      email: 'can@elite.com',
      photoUrl: 'https://i.pravatar.cc/150?img=18',
      rating: 4.5,
      totalAppointments: 340,
      totalRevenue: 68000.0,
      isActive: true,
      workingHours: '09:00-18:00',
      specialties: ['Saç Yıkama', 'Fön'],
      createdAt: DateTime.now().subtract(const Duration(days: 200)),
    ),
  ];
}
