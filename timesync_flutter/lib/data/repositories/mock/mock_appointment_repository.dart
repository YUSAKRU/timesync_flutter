import 'dart:math';
import '../../models/appointment_model.dart';
import '../result.dart';

/// Mock Appointment Repository
/// Simulates API calls for appointment management
class MockAppointmentRepository {
  final _random = Random();

  // Simulate network delay
  Future<void> _delay() async {
    await Future.delayed(Duration(milliseconds: 400 + _random.nextInt(800)));
  }

  /// Get appointments for a user (customer or employee)
  Future<Result<List<AppointmentModel>>> getUserAppointments({
    required String userId,
    AppointmentStatus? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      await _delay();

      var appointments = _mockAppointments
          .where((a) => a.customerId == userId || a.employeeId == userId)
          .toList();

      // Apply status filter
      if (status != null) {
        appointments = appointments.where((a) => a.status == status).toList();
      }

      // Apply date range filter
      if (startDate != null) {
        appointments = appointments.where((a) => a.dateTime.isAfter(startDate)).toList();
      }
      if (endDate != null) {
        appointments = appointments.where((a) => a.dateTime.isBefore(endDate)).toList();
      }

      // Sort by date (newest first)
      appointments.sort((a, b) => b.dateTime.compareTo(a.dateTime));

      return Result.success(appointments);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get business appointments
  Future<Result<List<AppointmentModel>>> getBusinessAppointments({
    required String businessId,
    AppointmentStatus? status,
    DateTime? date,
  }) async {
    try {
      await _delay();

      var appointments = _mockAppointments
          .where((a) => a.businessId == businessId)
          .toList();

      // Apply status filter
      if (status != null) {
        appointments = appointments.where((a) => a.status == status).toList();
      }

      // Apply date filter
      if (date != null) {
        appointments = appointments.where((a) {
          return a.dateTime.year == date.year &&
              a.dateTime.month == date.month &&
              a.dateTime.day == date.day;
        }).toList();
      }

      // Sort by date
      appointments.sort((a, b) => a.dateTime.compareTo(b.dateTime));

      return Result.success(appointments);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get appointment by ID
  Future<Result<AppointmentModel>> getAppointmentById(String id) async {
    try {
      await _delay();

      final appointment = _mockAppointments.firstWhere(
        (a) => a.id == id,
        orElse: () => throw Exception('Appointment not found'),
      );

      return Result.success(appointment);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Create new appointment
  Future<Result<AppointmentModel>> createAppointment({
    required String businessId,
    required String serviceId,
    required String userId,
    String? employeeId,
    required DateTime appointmentDate,
    required String timeSlot,
    String? notes,
  }) async {
    try {
      await _delay();

      final newAppointment = AppointmentModel(
        id: 'apt_${DateTime.now().millisecondsSinceEpoch}',
        businessId: businessId,
        businessName: 'İşletme Adı', // TODO: Get from business repository
        customerId: userId,
        customerName: 'Müşteri Adı', // TODO: Get from user repository
        serviceIds: [serviceId],
        serviceNames: ['Hizmet Adı'], // TODO: Get from service repository
        employeeId: employeeId ?? 'emp_unknown',
        employeeName: 'Çalışan Adı', // TODO: Get from employee repository
        dateTime: appointmentDate,
        duration: 60, // TODO: Calculate from services
        totalPrice: 0, // TODO: Calculate from services
        status: AppointmentStatus.pending,
        notes: notes,
        createdAt: DateTime.now(),
      );

      return Result.success(newAppointment);
    } catch (e) {
      return Result.failure('Randevu oluşturulamadı: ${e.toString()}');
    }
  }

  /// Update appointment status
  Future<Result<AppointmentModel>> updateAppointmentStatus({
    required String appointmentId,
    required AppointmentStatus newStatus,
  }) async {
    try {
      await _delay();

      final appointment = _mockAppointments.firstWhere(
        (a) => a.id == appointmentId,
        orElse: () => throw Exception('Appointment not found'),
      );

      final updatedAppointment = appointment.copyWith(status: newStatus);

      return Result.success(updatedAppointment);
    } catch (e) {
      return Result.failure('Durum güncellenemedi: ${e.toString()}');
    }
  }

  /// Cancel appointment
  Future<Result<AppointmentModel>> cancelAppointment({
    required String appointmentId,
    String? cancellationReason,
  }) async {
    try {
      await _delay();

      final appointment = _mockAppointments.firstWhere(
        (a) => a.id == appointmentId,
        orElse: () => throw Exception('Randevu bulunamadı'),
      );

      // Update status to cancelled
      final cancelledAppointment = appointment.copyWith(
        status: AppointmentStatus.cancelled,
        cancelReason: cancellationReason,
      );

      return Result.success(cancelledAppointment);
    } catch (e) {
      return Result.failure('Randevu iptal edilemedi: ${e.toString()}');
    }
  }

  // Mock data - 30+ appointments
  final List<AppointmentModel> _mockAppointments = [
    // Upcoming appointments
    AppointmentModel(
      id: 'apt1',
      businessId: 'biz1',
      businessName: 'Elite Kuaför & Berber',
      customerId: 'user1',
      customerName: 'Ahmet Yılmaz',
      serviceIds: ['srv1'],
      serviceNames: ['Saç Kesimi'],
      employeeId: 'emp1',
      employeeName: 'Mehmet Usta',
      dateTime: DateTime.now().add(const Duration(days: 2)),
      duration: 45,
      totalPrice: 250.0,
      status: AppointmentStatus.confirmed,
      notes: 'Yarım numara istiyorum',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    AppointmentModel(
      id: 'apt2',
      businessId: 'biz2',
      businessName: 'Güzellik Salonu Premium',
      customerId: 'user1',
      customerName: 'Ayşe Demir',
      serviceIds: ['srv5', 'srv6'],
      serviceNames: ['Manikür', 'Pedikür'],
      employeeId: 'emp2',
      employeeName: 'Zeynep Hanım',
      dateTime: DateTime.now().add(const Duration(days: 5)),
      duration: 90,
      totalPrice: 350.0,
      status: AppointmentStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    AppointmentModel(
      id: 'apt3',
      businessId: 'biz3',
      businessName: 'Spa & Masaj Merkezi',
      customerId: 'user2',
      customerName: 'Mehmet Kaya',
      serviceIds: ['srv9'],
      serviceNames: ['Relax Masajı'],
      employeeId: 'emp3',
      employeeName: 'Ali Masöz',
      dateTime: DateTime.now().add(const Duration(hours: 3)),
      duration: 60,
      totalPrice: 400.0,
      status: AppointmentStatus.pending,
      notes: 'Sırt ağrısı var',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    AppointmentModel(
      id: 'apt4',
      businessId: 'biz1',
      businessName: 'Elite Kuaför & Berber',
      customerId: 'user3',
      customerName: 'Fatma Şahin',
      serviceIds: ['srv2'],
      serviceNames: ['Saç Boyama'],
      employeeId: 'emp1',
      employeeName: 'Mehmet Usta',
      dateTime: DateTime.now().add(const Duration(days: 1)),
      duration: 120,
      totalPrice: 800.0,
      status: AppointmentStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    AppointmentModel(
      id: 'apt5',
      businessId: 'biz4',
      businessName: 'Nail Art Studio',
      customerId: 'user1',
      customerName: 'Ahmet Yılmaz',
      serviceIds: ['srv14'],
      serviceNames: ['Protez Tırnak'],
      employeeId: 'emp4',
      employeeName: 'Selin Hanım',
      dateTime: DateTime.now().add(const Duration(days: 7)),
      duration: 120,
      totalPrice: 500.0,
      status: AppointmentStatus.pending,
      createdAt: DateTime.now(),
    ),

    // Past appointments
    AppointmentModel(
      id: 'apt6',
      businessId: 'biz1',
      businessName: 'Elite Kuaför & Berber',
      customerId: 'user1',
      customerName: 'Ahmet Yılmaz',
      serviceIds: ['srv1'],
      serviceNames: ['Saç Kesimi'],
      employeeId: 'emp1',
      employeeName: 'Mehmet Usta',
      dateTime: DateTime.now().subtract(const Duration(days: 15)),
      duration: 45,
      totalPrice: 250.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    AppointmentModel(
      id: 'apt7',
      businessId: 'biz2',
      businessName: 'Güzellik Salonu Premium',
      customerId: 'user2',
      customerName: 'Mehmet Kaya',
      serviceIds: ['srv8'],
      serviceNames: ['Cilt Bakımı'],
      employeeId: 'emp2',
      employeeName: 'Zeynep Hanım',
      dateTime: DateTime.now().subtract(const Duration(days: 30)),
      duration: 60,
      totalPrice: 450.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 35)),
    ),
    AppointmentModel(
      id: 'apt8',
      businessId: 'biz5',
      businessName: 'Barbershop Classic',
      customerId: 'user1',
      customerName: 'Ahmet Yılmaz',
      serviceIds: ['srv17'],
      serviceNames: ['Sakal Düzenleme'],
      employeeId: 'emp5',
      employeeName: 'Hasan Berber',
      dateTime: DateTime.now().subtract(const Duration(days: 7)),
      duration: 30,
      totalPrice: 150.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    AppointmentModel(
      id: 'apt9',
      businessId: 'biz3',
      businessName: 'Spa & Masaj Merkezi',
      customerId: 'user3',
      customerName: 'Fatma Şahin',
      serviceIds: ['srv11'],
      serviceNames: ['Aromaterapi Masajı'],
      employeeId: 'emp3',
      employeeName: 'Ali Masöz',
      dateTime: DateTime.now().subtract(const Duration(days: 2)),
      duration: 90,
      totalPrice: 600.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    AppointmentModel(
      id: 'apt10',
      businessId: 'biz6',
      businessName: 'Cilt Bakım Kliniği',
      customerId: 'user2',
      customerName: 'Mehmet Kaya',
      serviceIds: ['srv19'],
      serviceNames: ['Lazer Epilasyon'],
      employeeId: 'emp6',
      employeeName: 'Dr. Aylin',
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      duration: 45,
      totalPrice: 800.0,
      status: AppointmentStatus.noShow,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),

    // Cancelled appointments
    AppointmentModel(
      id: 'apt11',
      businessId: 'biz7',
      businessName: 'Yoga & Meditasyon',
      customerId: 'user1',
      customerName: 'Ahmet Yılmaz',
      serviceIds: ['srv22'],
      serviceNames: ['Yoga Dersi'],
      employeeId: 'emp7',
      employeeName: 'Elif Öğretmen',
      dateTime: DateTime.now().subtract(const Duration(days: 5)),
      duration: 60,
      totalPrice: 200.0,
      status: AppointmentStatus.cancelled,
      notes: 'İş çıktı, maalesef gelemiyorum',
      cancelReason: 'Kullanıcı tarafından iptal edildi',
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
    AppointmentModel(
      id: 'apt12',
      businessId: 'biz8',
      businessName: 'Men\'s Grooming',
      customerId: 'user2',
      customerName: 'Mehmet Kaya',
      serviceIds: ['srv25'],
      serviceNames: ['Cilt Bakımı (Erkek)'],
      employeeId: 'emp8',
      employeeName: 'Burak Usta',
      dateTime: DateTime.now().subtract(const Duration(days: 10)),
      duration: 45,
      totalPrice: 300.0,
      status: AppointmentStatus.cancelled,
      notes: 'Hasta oldum',
      cancelReason: 'Sağlık sorunları',
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
    ),

    // More upcoming appointments (next 2 weeks)
    AppointmentModel(
      id: 'apt13',
      businessId: 'biz9',
      businessName: 'Lazer Epilasyon',
      customerId: 'user3',
      customerName: 'Fatma Şahin',
      serviceIds: ['srv28'],
      serviceNames: ['Lazer Epilasyon - Tam Bacak'],
      employeeId: 'emp9',
      employeeName: 'Dr. Derya',
      dateTime: DateTime.now().add(const Duration(days: 3, hours: 10)),
      duration: 60,
      totalPrice: 1200.0,
      status: AppointmentStatus.confirmed,
      notes: '3. seans',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    AppointmentModel(
      id: 'apt14',
      businessId: 'biz10',
      businessName: 'Saç Ekim Merkezi',
      customerId: 'user4',
      customerName: 'Kemal Arslan',
      serviceIds: ['srv30'],
      serviceNames: ['Saç Ekim Konsültasyonu'],
      employeeId: 'emp10',
      employeeName: 'Dr. Murat',
      dateTime: DateTime.now().add(const Duration(days: 4, hours: 14)),
      duration: 30,
      totalPrice: 0.0,
      status: AppointmentStatus.pending,
      notes: 'İlk görüşme - ücretsiz',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    AppointmentModel(
      id: 'apt15',
      businessId: 'biz11',
      businessName: 'Pilates Studio',
      customerId: 'user1',
      customerName: 'Ahmet Yılmaz',
      serviceIds: ['srv32'],
      serviceNames: ['Reformer Pilates'],
      employeeId: 'emp11',
      employeeName: 'Ayşe Antrenör',
      dateTime: DateTime.now().add(const Duration(days: 6, hours: 9)),
      duration: 50,
      totalPrice: 350.0,
      status: AppointmentStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    AppointmentModel(
      id: 'apt16',
      businessId: 'biz12',
      businessName: 'Makyaj Atölyesi',
      customerId: 'user5',
      customerName: 'Selin Yıldız',
      serviceIds: ['srv34', 'srv35'],
      serviceNames: ['Gelin Makyajı', 'Saç Tasarımı'],
      employeeId: 'emp12',
      employeeName: 'Canan Makyöz',
      dateTime: DateTime.now().add(const Duration(days: 8, hours: 11)),
      duration: 180,
      totalPrice: 2500.0,
      status: AppointmentStatus.confirmed,
      notes: 'Düğün: 25 Aralık 2025',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    AppointmentModel(
      id: 'apt17',
      businessId: 'biz13',
      businessName: 'Thai Masajı',
      customerId: 'user2',
      customerName: 'Mehmet Kaya',
      serviceIds: ['srv37'],
      serviceNames: ['Thai Masajı (90 dk)'],
      employeeId: 'emp13',
      employeeName: 'Nong Masöz',
      dateTime: DateTime.now().add(const Duration(days: 9, hours: 15)),
      duration: 90,
      totalPrice: 700.0,
      status: AppointmentStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
    AppointmentModel(
      id: 'apt18',
      businessId: 'biz14',
      businessName: 'Saç Tasarım Stüdyosu',
      customerId: 'user3',
      customerName: 'Fatma Şahin',
      serviceIds: ['srv39'],
      serviceNames: ['Ombre Saç Boyama'],
      employeeId: 'emp14',
      employeeName: 'Deniz Stilist',
      dateTime: DateTime.now().add(const Duration(days: 10, hours: 13)),
      duration: 150,
      totalPrice: 1500.0,
      status: AppointmentStatus.pending,
      notes: 'Koyu kahve tonları',
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
    AppointmentModel(
      id: 'apt19',
      businessId: 'biz15',
      businessName: 'Wellness Center',
      customerId: 'user6',
      customerName: 'Can Öztürk',
      serviceIds: ['srv41', 'srv42'],
      serviceNames: ['Sauna', 'Masaj'],
      employeeId: 'emp15',
      employeeName: 'Emre Terapist',
      dateTime: DateTime.now().add(const Duration(days: 11, hours: 16)),
      duration: 120,
      totalPrice: 850.0,
      status: AppointmentStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
    ),
    AppointmentModel(
      id: 'apt20',
      businessId: 'biz16',
      businessName: 'Kaş & Kirpik Studio',
      customerId: 'user5',
      customerName: 'Selin Yıldız',
      serviceIds: ['srv44'],
      serviceNames: ['Kirpik Lifting'],
      employeeId: 'emp16',
      employeeName: 'Gizem Hanım',
      dateTime: DateTime.now().add(const Duration(days: 12, hours: 10)),
      duration: 60,
      totalPrice: 400.0,
      status: AppointmentStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),

    // More past appointments (last 3 months)
    AppointmentModel(
      id: 'apt21',
      businessId: 'biz1',
      businessName: 'Elite Kuaför & Berber',
      customerId: 'user1',
      customerName: 'Ahmet Yılmaz',
      serviceIds: ['srv1', 'srv3'],
      serviceNames: ['Saç Kesimi', 'Sakal Tıraşı'],
      employeeId: 'emp1',
      employeeName: 'Mehmet Usta',
      dateTime: DateTime.now().subtract(const Duration(days: 45)),
      duration: 60,
      totalPrice: 350.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 50)),
    ),
    AppointmentModel(
      id: 'apt22',
      businessId: 'biz2',
      businessName: 'Güzellik Salonu Premium',
      customerId: 'user3',
      customerName: 'Fatma Şahin',
      serviceIds: ['srv7'],
      serviceNames: ['Protez Tırnak'],
      employeeId: 'emp2',
      employeeName: 'Zeynep Hanım',
      dateTime: DateTime.now().subtract(const Duration(days: 21)),
      duration: 120,
      totalPrice: 550.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
    ),
    AppointmentModel(
      id: 'apt23',
      businessId: 'biz4',
      businessName: 'Nail Art Studio',
      customerId: 'user5',
      customerName: 'Selin Yıldız',
      serviceIds: ['srv14'],
      serviceNames: ['French Manikür'],
      employeeId: 'emp4',
      employeeName: 'Selin Hanım',
      dateTime: DateTime.now().subtract(const Duration(days: 14)),
      duration: 90,
      totalPrice: 450.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 18)),
    ),
    AppointmentModel(
      id: 'apt24',
      businessId: 'biz5',
      businessName: 'Barbershop Classic',
      customerId: 'user2',
      customerName: 'Mehmet Kaya',
      serviceIds: ['srv17', 'srv18'],
      serviceNames: ['Saç Kesimi', 'Sakal Şekillendirme'],
      employeeId: 'emp5',
      employeeName: 'Hasan Berber',
      dateTime: DateTime.now().subtract(const Duration(days: 28)),
      duration: 45,
      totalPrice: 300.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 32)),
    ),
    AppointmentModel(
      id: 'apt25',
      businessId: 'biz3',
      businessName: 'Spa & Masaj Merkezi',
      customerId: 'user4',
      customerName: 'Kemal Arslan',
      serviceIds: ['srv10'],
      serviceNames: ['Sıcak Taş Masajı'],
      employeeId: 'emp3',
      employeeName: 'Ali Masöz',
      dateTime: DateTime.now().subtract(const Duration(days: 35)),
      duration: 75,
      totalPrice: 650.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 40)),
    ),
    AppointmentModel(
      id: 'apt26',
      businessId: 'biz6',
      businessName: 'Cilt Bakım Kliniği',
      customerId: 'user3',
      customerName: 'Fatma Şahin',
      serviceIds: ['srv20'],
      serviceNames: ['Yüz Bakımı'],
      employeeId: 'emp6',
      employeeName: 'Dr. Aylin',
      dateTime: DateTime.now().subtract(const Duration(days: 42)),
      duration: 90,
      totalPrice: 800.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 48)),
    ),
    AppointmentModel(
      id: 'apt27',
      businessId: 'biz7',
      businessName: 'Yoga & Meditasyon',
      customerId: 'user6',
      customerName: 'Can Öztürk',
      serviceIds: ['srv23'],
      serviceNames: ['Meditasyon Seansı'],
      employeeId: 'emp7',
      employeeName: 'Elif Öğretmen',
      dateTime: DateTime.now().subtract(const Duration(days: 56)),
      duration: 60,
      totalPrice: 250.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
    ),
    AppointmentModel(
      id: 'apt28',
      businessId: 'biz8',
      businessName: 'Men\'s Grooming',
      customerId: 'user1',
      customerName: 'Ahmet Yılmaz',
      serviceIds: ['srv26'],
      serviceNames: ['Saç Kesimi + Sakal'],
      employeeId: 'emp8',
      employeeName: 'Burak Usta',
      dateTime: DateTime.now().subtract(const Duration(days: 63)),
      duration: 60,
      totalPrice: 400.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 68)),
    ),
    AppointmentModel(
      id: 'apt29',
      businessId: 'biz9',
      businessName: 'Lazer Epilasyon',
      customerId: 'user5',
      customerName: 'Selin Yıldız',
      serviceIds: ['srv28'],
      serviceNames: ['Lazer Epilasyon - Koltuk Altı'],
      employeeId: 'emp9',
      employeeName: 'Dr. Derya',
      dateTime: DateTime.now().subtract(const Duration(days: 70)),
      duration: 30,
      totalPrice: 500.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 75)),
    ),
    AppointmentModel(
      id: 'apt30',
      businessId: 'biz11',
      businessName: 'Pilates Studio',
      customerId: 'user2',
      customerName: 'Mehmet Kaya',
      serviceIds: ['srv32'],
      serviceNames: ['Mat Pilates'],
      employeeId: 'emp11',
      employeeName: 'Ayşe Antrenör',
      dateTime: DateTime.now().subtract(const Duration(days: 77)),
      duration: 50,
      totalPrice: 300.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 82)),
    ),

    // More cancelled appointments
    AppointmentModel(
      id: 'apt31',
      businessId: 'biz12',
      businessName: 'Makyaj Atölyesi',
      customerId: 'user3',
      customerName: 'Fatma Şahin',
      serviceIds: ['srv34'],
      serviceNames: ['Özel Gün Makyajı'],
      employeeId: 'emp12',
      employeeName: 'Canan Makyöz',
      dateTime: DateTime.now().subtract(const Duration(days: 12)),
      duration: 90,
      totalPrice: 600.0,
      status: AppointmentStatus.cancelled,
      notes: 'Etkinlik ertelendi',
      cancelReason: 'Kullanıcı tarafından iptal',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    AppointmentModel(
      id: 'apt32',
      businessId: 'biz13',
      businessName: 'Thai Masajı',
      customerId: 'user4',
      customerName: 'Kemal Arslan',
      serviceIds: ['srv37'],
      serviceNames: ['Thai Masajı (60 dk)'],
      employeeId: 'emp13',
      employeeName: 'Nong Masöz',
      dateTime: DateTime.now().subtract(const Duration(days: 8)),
      duration: 60,
      totalPrice: 550.0,
      status: AppointmentStatus.cancelled,
      notes: 'Şehir dışına çıkacağım',
      cancelReason: 'Seyahat planı',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    AppointmentModel(
      id: 'apt33',
      businessId: 'biz14',
      businessName: 'Saç Tasarım Stüdyosu',
      customerId: 'user6',
      customerName: 'Can Öztürk',
      serviceIds: ['srv39'],
      serviceNames: ['Saç Kesimi'],
      employeeId: 'emp14',
      employeeName: 'Deniz Stilist',
      dateTime: DateTime.now().subtract(const Duration(days: 3)),
      duration: 45,
      totalPrice: 400.0,
      status: AppointmentStatus.cancelled,
      cancelReason: 'İşletme tarafından iptal',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),

    // No-show appointments
    AppointmentModel(
      id: 'apt34',
      businessId: 'biz15',
      businessName: 'Wellness Center',
      customerId: 'user1',
      customerName: 'Ahmet Yılmaz',
      serviceIds: ['srv41'],
      serviceNames: ['Sauna'],
      employeeId: 'emp15',
      employeeName: 'Emre Terapist',
      dateTime: DateTime.now().subtract(const Duration(days: 4)),
      duration: 60,
      totalPrice: 300.0,
      status: AppointmentStatus.noShow,
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
    AppointmentModel(
      id: 'apt35',
      businessId: 'biz16',
      businessName: 'Kaş & Kirpik Studio',
      customerId: 'user2',
      customerName: 'Mehmet Kaya',
      serviceIds: ['srv43'],
      serviceNames: ['Kaş Tasarımı'],
      employeeId: 'emp16',
      employeeName: 'Gizem Hanım',
      dateTime: DateTime.now().subtract(const Duration(days: 6)),
      duration: 30,
      totalPrice: 200.0,
      status: AppointmentStatus.noShow,
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
    ),

    // Additional upcoming for variety
    AppointmentModel(
      id: 'apt36',
      businessId: 'biz1',
      businessName: 'Elite Kuaför & Berber',
      customerId: 'user4',
      customerName: 'Kemal Arslan',
      serviceIds: ['srv1'],
      serviceNames: ['Saç Kesimi'],
      employeeId: 'emp1',
      employeeName: 'Mehmet Usta',
      dateTime: DateTime.now().add(const Duration(days: 13, hours: 11)),
      duration: 45,
      totalPrice: 250.0,
      status: AppointmentStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    AppointmentModel(
      id: 'apt37',
      businessId: 'biz2',
      businessName: 'Güzellik Salonu Premium',
      customerId: 'user6',
      customerName: 'Can Öztürk',
      serviceIds: ['srv6'],
      serviceNames: ['Pedikür'],
      employeeId: 'emp2',
      employeeName: 'Zeynep Hanım',
      dateTime: DateTime.now().add(const Duration(days: 14, hours: 15)),
      duration: 45,
      totalPrice: 200.0,
      status: AppointmentStatus.pending,
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
    ),
    AppointmentModel(
      id: 'apt38',
      businessId: 'biz3',
      businessName: 'Spa & Masaj Merkezi',
      customerId: 'user5',
      customerName: 'Selin Yıldız',
      serviceIds: ['srv11'],
      serviceNames: ['Aromaterapi'],
      employeeId: 'emp3',
      employeeName: 'Ali Masöz',
      dateTime: DateTime.now().add(const Duration(hours: 48)),
      duration: 90,
      totalPrice: 600.0,
      status: AppointmentStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(hours: 24)),
    ),
    AppointmentModel(
      id: 'apt39',
      businessId: 'biz4',
      businessName: 'Nail Art Studio',
      customerId: 'user1',
      customerName: 'Ahmet Yılmaz',
      serviceIds: ['srv15'],
      serviceNames: ['Nail Art Design'],
      employeeId: 'emp4',
      employeeName: 'Selin Hanım',
      dateTime: DateTime.now().add(const Duration(hours: 72)),
      duration: 60,
      totalPrice: 350.0,
      status: AppointmentStatus.confirmed,
      notes: 'Geometrik desenler',
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
    AppointmentModel(
      id: 'apt40',
      businessId: 'biz5',
      businessName: 'Barbershop Classic',
      customerId: 'user3',
      customerName: 'Fatma Şahin',
      serviceIds: ['srv17'],
      serviceNames: ['Çocuk Saç Kesimi'],
      employeeId: 'emp5',
      employeeName: 'Hasan Berber',
      dateTime: DateTime.now().add(const Duration(hours: 96)),
      duration: 30,
      totalPrice: 150.0,
      status: AppointmentStatus.confirmed,
      notes: 'Oğlum için, 8 yaşında',
      createdAt: DateTime.now().subtract(const Duration(hours: 36)),
    ),

    // Recent completed
    AppointmentModel(
      id: 'apt41',
      businessId: 'biz6',
      businessName: 'Cilt Bakım Kliniği',
      customerId: 'user4',
      customerName: 'Kemal Arslan',
      serviceIds: ['srv19'],
      serviceNames: ['Cilt Analizi'],
      employeeId: 'emp6',
      employeeName: 'Dr. Aylin',
      dateTime: DateTime.now().subtract(const Duration(hours: 36)),
      duration: 30,
      totalPrice: 250.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    AppointmentModel(
      id: 'apt42',
      businessId: 'biz7',
      businessName: 'Yoga & Meditasyon',
      customerId: 'user5',
      customerName: 'Selin Yıldız',
      serviceIds: ['srv22'],
      serviceNames: ['Power Yoga'],
      employeeId: 'emp7',
      employeeName: 'Elif Öğretmen',
      dateTime: DateTime.now().subtract(const Duration(hours: 60)),
      duration: 60,
      totalPrice: 250.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    AppointmentModel(
      id: 'apt43',
      businessId: 'biz8',
      businessName: 'Men\'s Grooming',
      customerId: 'user6',
      customerName: 'Can Öztürk',
      serviceIds: ['srv25'],
      serviceNames: ['Yüz Temizliği'],
      employeeId: 'emp8',
      employeeName: 'Burak Usta',
      dateTime: DateTime.now().subtract(const Duration(hours: 84)),
      duration: 45,
      totalPrice: 350.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    AppointmentModel(
      id: 'apt44',
      businessId: 'biz9',
      businessName: 'Lazer Epilasyon',
      customerId: 'user2',
      customerName: 'Mehmet Kaya',
      serviceIds: ['srv27'],
      serviceNames: ['Lazer Epilasyon - Yüz'],
      employeeId: 'emp9',
      employeeName: 'Dr. Derya',
      dateTime: DateTime.now().subtract(const Duration(hours: 108)),
      duration: 30,
      totalPrice: 400.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
    AppointmentModel(
      id: 'apt45',
      businessId: 'biz10',
      businessName: 'Saç Ekim Merkezi',
      customerId: 'user1',
      customerName: 'Ahmet Yılmaz',
      serviceIds: ['srv29'],
      serviceNames: ['Saç Mezoterapisi'],
      employeeId: 'emp10',
      employeeName: 'Dr. Murat',
      dateTime: DateTime.now().subtract(const Duration(hours: 132)),
      duration: 45,
      totalPrice: 800.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    AppointmentModel(
      id: 'apt46',
      businessId: 'biz11',
      businessName: 'Pilates Studio',
      customerId: 'user3',
      customerName: 'Fatma Şahin',
      serviceIds: ['srv31'],
      serviceNames: ['Mat Pilates'],
      employeeId: 'emp11',
      employeeName: 'Ayşe Antrenör',
      dateTime: DateTime.now().subtract(const Duration(hours: 156)),
      duration: 50,
      totalPrice: 300.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
    ),
    AppointmentModel(
      id: 'apt47',
      businessId: 'biz12',
      businessName: 'Makyaj Atölyesi',
      customerId: 'user4',
      customerName: 'Kemal Arslan',
      serviceIds: ['srv33'],
      serviceNames: ['Makyaj Dersi'],
      employeeId: 'emp12',
      employeeName: 'Canan Makyöz',
      dateTime: DateTime.now().subtract(const Duration(hours: 180)),
      duration: 120,
      totalPrice: 500.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    AppointmentModel(
      id: 'apt48',
      businessId: 'biz13',
      businessName: 'Thai Masajı',
      customerId: 'user5',
      customerName: 'Selin Yıldız',
      serviceIds: ['srv36'],
      serviceNames: ['Thai Masajı (120 dk)'],
      employeeId: 'emp13',
      employeeName: 'Nong Masöz',
      dateTime: DateTime.now().subtract(const Duration(hours: 204)),
      duration: 120,
      totalPrice: 900.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 18)),
    ),
    AppointmentModel(
      id: 'apt49',
      businessId: 'biz14',
      businessName: 'Saç Tasarım Stüdyosu',
      customerId: 'user6',
      customerName: 'Can Öztürk',
      serviceIds: ['srv38'],
      serviceNames: ['Balayage Saç Boyama'],
      employeeId: 'emp14',
      employeeName: 'Deniz Stilist',
      dateTime: DateTime.now().subtract(const Duration(hours: 228)),
      duration: 180,
      totalPrice: 2000.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    AppointmentModel(
      id: 'apt50',
      businessId: 'biz15',
      businessName: 'Wellness Center',
      customerId: 'user1',
      customerName: 'Ahmet Yılmaz',
      serviceIds: ['srv40', 'srv41'],
      serviceNames: ['Hamam', 'Kese-Köpük'],
      employeeId: 'emp15',
      employeeName: 'Emre Terapist',
      dateTime: DateTime.now().subtract(const Duration(hours: 252)),
      duration: 90,
      totalPrice: 600.0,
      status: AppointmentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 22)),
    ),
  ];

  /// Get upcoming appointments for a user
  Future<Result<List<AppointmentModel>>> getUpcomingAppointments({
    required String userId,
  }) async {
    try {
      await _delay();

      final now = DateTime.now();
      final appointments = _mockAppointments
          .where((a) =>
              (a.customerId == userId || a.employeeId == userId) &&
              a.dateTime.isAfter(now) &&
              (a.status == AppointmentStatus.confirmed ||
                  a.status == AppointmentStatus.pending))
          .toList()
        ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

      return Result.success(appointments);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get past appointments for a user
  Future<Result<List<AppointmentModel>>> getPastAppointments({
    required String userId,
  }) async {
    try {
      await _delay();

      final now = DateTime.now();
      final appointments = _mockAppointments
          .where((a) =>
              (a.customerId == userId || a.employeeId == userId) &&
              (a.dateTime.isBefore(now) ||
                  a.status == AppointmentStatus.completed ||
                  a.status == AppointmentStatus.cancelled ||
                  a.status == AppointmentStatus.noShow))
          .toList()
        ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

      return Result.success(appointments);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
