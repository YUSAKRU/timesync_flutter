import 'dart:math';
import '../../models/service_model.dart';
import '../../models/time_slot_model.dart';
import '../result.dart';

/// Mock Service Repository
/// Simulates API calls for service management
class MockServiceRepository {
  final _random = Random();

  // Simulate network delay
  Future<void> _delay() async {
    await Future.delayed(Duration(milliseconds: 300 + _random.nextInt(700)));
  }

  /// Get services by business ID
  Future<Result<List<ServiceModel>>> getBusinessServices({
    required String businessId,
    bool activeOnly = false,
  }) async {
    try {
      await _delay();

      var services = _mockServices
          .where((s) => s.businessId == businessId)
          .toList();

      // Sort by price (lowest first)
      services.sort((a, b) => a.price.compareTo(b.price));

      return Result.success(services);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get service by ID
  Future<Result<ServiceModel>> getServiceById(String id) async {
    try {
      await _delay();

      final service = _mockServices.firstWhere(
        (s) => s.id == id,
        orElse: () => throw Exception('Hizmet bulunamadı'),
      );

      return Result.success(service);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get popular services
  Future<Result<List<ServiceModel>>> getPopularServices({
    String? businessId,
    int limit = 5,
  }) async {
    try {
      await _delay();

      var services = businessId != null
          ? _mockServices.where((s) => s.businessId == businessId).toList()
          : List<ServiceModel>.from(_mockServices);

      // Sort by booking count (mock - using price as proxy)
      services.sort((a, b) => b.price.compareTo(a.price));

      return Result.success(services.take(limit).toList());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Create new service
  Future<Result<ServiceModel>> createService({
    required String businessId,
    required String name,
    required String category,
    required double price,
    required int duration,
    String? description,
  }) async {
    try {
      await _delay();

      final newService = ServiceModel(
        id: 'srv_${DateTime.now().millisecondsSinceEpoch}',
        businessId: businessId,
        name: name,
        category: category,
        price: price,
        duration: duration,
        description: description,
      );

      return Result.success(newService);
    } catch (e) {
      return Result.failure('Hizmet eklenemedi: ${e.toString()}');
    }
  }

  /// Update service
  Future<Result<ServiceModel>> updateService({
    required String serviceId,
    String? name,
    String? category,
    double? price,
    int? duration,
    String? description,
  }) async {
    try {
      await _delay();

      final service = _mockServices.firstWhere(
        (s) => s.id == serviceId,
        orElse: () => throw Exception('Hizmet bulunamadı'),
      );

      final updatedService = service.copyWith(
        name: name ?? service.name,
        category: category ?? service.category,
        price: price ?? service.price,
        duration: duration ?? service.duration,
        description: description ?? service.description,
      );

      return Result.success(updatedService);
    } catch (e) {
      return Result.failure('Hizmet güncellenemedi: ${e.toString()}');
    }
  }

  /// Delete service
  Future<Result<bool>> deleteService(String serviceId) async {
    try {
      await _delay();

      final exists = _mockServices.any((s) => s.id == serviceId);
      if (!exists) {
        throw Exception('Hizmet bulunamadı');
      }

      return Result.success(true);
    } catch (e) {
      return Result.failure('Hizmet silinemedi: ${e.toString()}');
    }
  }

  /// Get available time slots for a service
  Future<Result<List<TimeSlotModel>>> getAvailableTimeSlots({
    required String businessId,
    required String serviceId,
    required DateTime date,
    String? employeeId,
  }) async {
    try {
      await _delay();

      // Generate mock time slots
      final timeSlots = <TimeSlotModel>[];
      final startHour = 9;
      final endHour = 18;

      for (int hour = startHour; hour < endHour; hour++) {
        for (int minute = 0; minute < 60; minute += 30) {
          final slotTime = DateTime(date.year, date.month, date.day, hour, minute);
          
          // Skip past times
          if (slotTime.isBefore(DateTime.now())) continue;
          
          final endTime = slotTime.add(const Duration(minutes: 30));
          
          timeSlots.add(TimeSlotModel(
            id: '${serviceId}_${hour}_$minute',
            businessId: businessId,
            employeeId: employeeId ?? '',
            startTime: slotTime,
            endTime: endTime,
            isAvailable: true,
          ));
        }
      }

      return Result.success(timeSlots);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  // Mock services for various businesses
  final List<ServiceModel> _mockServices = [
    // Elite Kuaför & Berber (biz1)
    const ServiceModel(
      id: 'srv1',
      businessId: 'biz1',
      name: 'Saç Kesimi',
      category: 'Saç',
      price: 250.0,
      duration: 45,
      description: 'Profesyonel saç kesimi ve şekillendirme',
    ),
    const ServiceModel(
      id: 'srv2',
      businessId: 'biz1',
      name: 'Saç Boyama',
      category: 'Saç',
      price: 800.0,
      duration: 120,
      description: 'Profesyonel saç boyama ve bakım',
    ),
    const ServiceModel(
      id: 'srv3',
      businessId: 'biz1',
      name: 'Sakal Tıraşı',
      category: 'Sakal',
      price: 150.0,
      duration: 30,
      description: 'Klasik ustura tıraşı',
    ),
    const ServiceModel(
      id: 'srv4',
      businessId: 'biz1',
      name: 'Saç + Sakal',
      category: 'Kombo',
      price: 350.0,
      duration: 60,
      description: 'Saç kesimi ve sakal tıraşı paketi',
    ),

    // Güzellik Salonu Premium (biz2)
    const ServiceModel(
      id: 'srv5',
      businessId: 'biz2',
      name: 'Manikür',
      category: 'Tırnak',
      price: 200.0,
      duration: 45,
      description: 'El ve tırnak bakımı',
    ),
    const ServiceModel(
      id: 'srv6',
      businessId: 'biz2',
      name: 'Pedikür',
      category: 'Tırnak',
      price: 250.0,
      duration: 60,
      description: 'Ayak ve tırnak bakımı',
    ),
    const ServiceModel(
      id: 'srv7',
      businessId: 'biz2',
      name: 'Manikür & Pedikür',
      category: 'Tırnak',
      price: 350.0,
      duration: 90,
      description: 'Tam el ve ayak bakımı',
    ),
    const ServiceModel(
      id: 'srv8',
      businessId: 'biz2',
      name: 'Cilt Bakımı',
      category: 'Cilt',
      price: 450.0,
      duration: 60,
      description: 'Profesyonel yüz cilt bakımı',
    ),

    // Spa & Masaj Merkezi (biz3)
    const ServiceModel(
      id: 'srv9',
      businessId: 'biz3',
      name: 'Relax Masajı',
      category: 'Masaj',
      price: 400.0,
      duration: 60,
      description: 'Rahatlatıcı tüm vücut masajı',
    ),
    const ServiceModel(
      id: 'srv10',
      businessId: 'biz3',
      name: 'Thai Masajı',
      category: 'Masaj',
      price: 500.0,
      duration: 90,
      description: 'Geleneksel Thai masaj teknikleri',
    ),
    const ServiceModel(
      id: 'srv11',
      businessId: 'biz3',
      name: 'Aromaterapi Masajı',
      category: 'Masaj',
      price: 600.0,
      duration: 90,
      description: 'Aromaterapi yağları ile masaj',
    ),
    const ServiceModel(
      id: 'srv12',
      businessId: 'biz3',
      name: 'Spa Paketi',
      category: 'Spa',
      price: 1200.0,
      duration: 180,
      description: 'Tam spa deneyimi - masaj, kese, hamam',
    ),

    // Nail Art Studio (biz4)
    const ServiceModel(
      id: 'srv13',
      businessId: 'biz4',
      name: 'Nail Art',
      category: 'Tırnak',
      price: 300.0,
      duration: 60,
      description: 'Özel nail art tasarımı',
    ),
    const ServiceModel(
      id: 'srv14',
      businessId: 'biz4',
      name: 'Protez Tırnak',
      category: 'Tırnak',
      price: 500.0,
      duration: 120,
      description: 'Kaliteli protez tırnak uygulaması',
    ),
    const ServiceModel(
      id: 'srv15',
      businessId: 'biz4',
      name: 'Kalıcı Oje',
      category: 'Tırnak',
      price: 250.0,
      duration: 45,
      description: '3 hafta dayanıklı oje',
    ),

    // Barbershop Classic (biz5)
    const ServiceModel(
      id: 'srv16',
      businessId: 'biz5',
      name: 'Klasik Kesim',
      category: 'Saç',
      price: 200.0,
      duration: 30,
      description: 'Klasik erkek saç kesimi',
    ),
    const ServiceModel(
      id: 'srv17',
      businessId: 'biz5',
      name: 'Sakal Düzenleme',
      category: 'Sakal',
      price: 150.0,
      duration: 30,
      description: 'Sakal şekillendirme ve düzenleme',
    ),
    const ServiceModel(
      id: 'srv18',
      businessId: 'biz5',
      name: 'Cilt Bakımı',
      category: 'Bakım',
      price: 300.0,
      duration: 45,
      description: 'Erkek cilt bakımı',
    ),

    // Cilt Bakım Kliniği (biz6)
    const ServiceModel(
      id: 'srv19',
      businessId: 'biz6',
      name: 'Lazer Epilasyon',
      category: 'Lazer',
      price: 800.0,
      duration: 45,
      description: 'Tek bölge lazer epilasyon',
    ),
    const ServiceModel(
      id: 'srv20',
      businessId: 'biz6',
      name: 'Botox',
      category: 'Estetik',
      price: 2500.0,
      duration: 30,
      description: 'Botox uygulaması',
    ),
    const ServiceModel(
      id: 'srv21',
      businessId: 'biz6',
      name: 'Dolgu',
      category: 'Estetik',
      price: 3000.0,
      duration: 45,
      description: 'Yüz dolgusu uygulaması',
    ),

    // Yoga & Meditasyon (biz7)
    const ServiceModel(
      id: 'srv22',
      businessId: 'biz7',
      name: 'Yoga Dersi',
      category: 'Yoga',
      price: 200.0,
      duration: 60,
      description: 'Grup yoga dersi',
    ),
    const ServiceModel(
      id: 'srv23',
      businessId: 'biz7',
      name: 'Özel Yoga',
      category: 'Yoga',
      price: 400.0,
      duration: 60,
      description: 'Birebir özel yoga dersi',
    ),
    const ServiceModel(
      id: 'srv24',
      businessId: 'biz7',
      name: 'Meditasyon',
      category: 'Meditasyon',
      price: 150.0,
      duration: 45,
      description: 'Rehberli meditasyon seansı',
    ),
  ];
}
