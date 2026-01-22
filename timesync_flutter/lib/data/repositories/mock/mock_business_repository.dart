import 'dart:math';

import '../../../core/storage/cache_manager.dart';
import '../../models/business_model.dart';
import '../result.dart';

/// Mock Business Repository
/// Simulates API calls with realistic delays and data
class MockBusinessRepository {
  final _random = Random();
  final CacheManager? _cacheManager;

  MockBusinessRepository({CacheManager? cacheManager})
      : _cacheManager = cacheManager;

  // Simulate network delay
  Future<void> _delay() async {
    await Future.delayed(Duration(milliseconds: 500 + _random.nextInt(1000)));
  }

  /// Get all businesses with optional filters
  Future<Result<List<BusinessModel>>> getBusinesses({
    String? category,
    String? searchQuery,
    int? limit,
    int? offset,
  }) async {
    try {
      // Try to get from cache first (only if no filters)
      if (_cacheManager != null && category == null && searchQuery == null) {
        final cached = _cacheManager!.getCachedBusinesses();
        if (cached != null) {
          return Result.success(cached);
        }
      }

      await _delay();

      var businesses = _mockBusinesses;

      // Apply category filter
      if (category != null && category != 'Tümü') {
        businesses = businesses.where((b) => b.category == category).toList();
      }

      // Apply search filter
      if (searchQuery != null && searchQuery.isNotEmpty) {
        businesses = businesses
            .where((b) =>
                b.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                b.description
                        ?.toLowerCase()
                        .contains(searchQuery.toLowerCase()) ==
                    true)
            .toList();
      }

      // Apply pagination
      if (offset != null || limit != null) {
        final start = offset ?? 0;
        final end = limit != null
            ? min(start + limit, businesses.length)
            : businesses.length;

        if (start < businesses.length) {
          businesses = businesses.sublist(start, end);
        } else {
          businesses = [];
        }
      }

      // Cache the result (only if no filters)
      if (_cacheManager != null &&
          category == null &&
          searchQuery == null &&
          offset == null) {
        await _cacheManager!.cacheBusinesses(businesses);
      }

      return Result.success(businesses);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get business by ID
  Future<Result<BusinessModel>> getBusinessById(String id) async {
    try {
      // Try to get from cache first
      if (_cacheManager != null) {
        final cached = _cacheManager!.getCachedBusiness(id);
        if (cached != null) {
          return Result.success(cached);
        }
      }

      await _delay();

      final business = _mockBusinesses.firstWhere(
        (b) => b.id == id,
        orElse: () => throw Exception('Business not found'),
      );

      // Cache the business
      if (_cacheManager != null) {
        await _cacheManager!.cacheBusiness(business);
      }

      return Result.success(business);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get featured/popular businesses
  Future<Result<List<BusinessModel>>> getFeaturedBusinesses(
      {int limit = 5}) async {
    try {
      // Try to get from cache first
      if (_cacheManager != null) {
        final cached = _cacheManager!.getCachedFeaturedBusinesses();
        if (cached != null && cached.length >= limit) {
          return Result.success(cached.take(limit).toList());
        }
      }

      await _delay();

      final featured = List<BusinessModel>.from(_mockBusinesses)
        ..sort((a, b) => b.rating.compareTo(a.rating));

      final result = featured.take(limit).toList();

      // Cache the result
      if (_cacheManager != null) {
        await _cacheManager!.cacheFeaturedBusinesses(result);
      }

      return Result.success(result);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  // Mock data - 25 businesses
  final List<BusinessModel> _mockBusinesses = [
    const BusinessModel(
      id: 'biz1',
      name: 'Elite Kuaför & Berber',
      category: 'Kuaför & Berber',
      location: 'Kadıköy',
      address: 'Moda Cad. No:45 Kadıköy/İstanbul',
      phone: '+90 216 555 01 01',
      email: 'info@elitekuafor.com',
      rating: 4.8,
      reviewCount: 342,
      imageUrl: 'https://images.unsplash.com/photo-1503951914875-452162b0f3f1',
      description: 'Profesyonel saç kesimi ve bakım hizmetleri',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz2',
      name: 'Güzellik Salonu Premium',
      category: 'Güzellik Salonu',
      location: 'Beşiktaş',
      address: 'Barbaros Bulvarı No:123 Beşiktaş/İstanbul',
      phone: '+90 212 555 02 02',
      email: 'info@guzellikpremium.com',
      rating: 4.9,
      reviewCount: 456,
      imageUrl: 'https://images.unsplash.com/photo-1560066984-138dadb4c035',
      description: 'Tam kapsamlı güzellik ve bakım hizmetleri',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz3',
      name: 'Spa & Masaj Merkezi',
      category: 'Spa & Masaj',
      location: 'Nişantaşı',
      address: 'Teşvikiye Cad. No:78 Şişli/İstanbul',
      phone: '+90 212 555 03 03',
      email: 'info@spamerkezi.com',
      rating: 4.7,
      reviewCount: 234,
      imageUrl: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874',
      description: 'Rahatlatıcı spa ve masaj terapileri',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz4',
      name: 'Nail Art Studio',
      category: 'Güzellik Salonu',
      location: 'Bağdat Caddesi',
      address: 'Bağdat Cad. No:234 Kadıköy/İstanbul',
      phone: '+90 216 555 04 04',
      email: 'info@nailart.com',
      rating: 4.6,
      reviewCount: 189,
      imageUrl: 'https://images.unsplash.com/photo-1604654894610-df63bc536371',
      description: 'Özel manikür ve nail art tasarımları',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz5',
      name: 'Barbershop Classic',
      category: 'Kuaför & Berber',
      location: 'Taksim',
      address: 'İstiklal Cad. No:156 Beyoğlu/İstanbul',
      phone: '+90 212 555 05 05',
      email: 'info@barbershop.com',
      rating: 4.5,
      reviewCount: 278,
      imageUrl: 'https://images.unsplash.com/photo-1585747860715-2ba37e788b70',
      description: 'Klasik berber ustalığı ve modern trendler',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz6',
      name: 'Cilt Bakım Kliniği',
      category: 'Güzellik Salonu',
      location: 'Etiler',
      address: 'Nispetiye Cad. No:89 Beşiktaş/İstanbul',
      phone: '+90 212 555 06 06',
      email: 'info@ciltbakim.com',
      rating: 4.9,
      reviewCount: 412,
      imageUrl: 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881',
      description: 'Profesyonel cilt bakımı ve tedavileri',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz7',
      name: 'Yoga & Meditasyon',
      category: 'Spa & Masaj',
      location: 'Caddebostan',
      address: 'Caddebostan Sahil Yolu No:45 Kadıköy/İstanbul',
      phone: '+90 216 555 07 07',
      email: 'info@yogastudio.com',
      rating: 4.8,
      reviewCount: 156,
      imageUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773',
      description: 'Yoga dersleri ve meditasyon seansları',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz8',
      name: 'Men\'s Grooming',
      category: 'Kuaför & Berber',
      location: 'Levent',
      address: 'Levent Cad. No:112 Beşiktaş/İstanbul',
      phone: '+90 212 555 08 08',
      email: 'info@mensgrooming.com',
      rating: 4.7,
      reviewCount: 298,
      imageUrl: 'https://images.unsplash.com/photo-1621605815971-fbc98d665033',
      description: 'Erkeklere özel bakım ve tıraş hizmetleri',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz9',
      name: 'Lazer Epilasyon',
      category: 'Güzellik Salonu',
      location: 'Şişli',
      address: 'Halaskargazi Cad. No:234 Şişli/İstanbul',
      phone: '+90 212 555 09 09',
      email: 'info@lazerepilasyon.com',
      rating: 4.6,
      reviewCount: 267,
      imageUrl: 'https://images.unsplash.com/photo-1519415943484-9fa1873496d4',
      description: 'Son teknoloji lazer epilasyon',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz10',
      name: 'Saç Ekim Merkezi',
      category: 'Kuaför & Berber',
      location: 'Mecidiyeköy',
      address: 'Büyükdere Cad. No:67 Şişli/İstanbul',
      phone: '+90 212 555 10 10',
      email: 'info@sacekim.com',
      rating: 4.8,
      reviewCount: 189,
      imageUrl: 'https://images.unsplash.com/photo-1622286346890-e4a488c8e4c6',
      description: 'Profesyonel saç ekimi ve tedavisi',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz11',
      name: 'Pilates Studio',
      category: 'Spa & Masaj',
      location: 'Bebek',
      address: 'Cevdetpaşa Cad. No:89 Beşiktaş/İstanbul',
      phone: '+90 212 555 11 11',
      email: 'info@pilatesstudio.com',
      rating: 4.7,
      reviewCount: 178,
      imageUrl: 'https://images.unsplash.com/photo-1518611012118-696072aa579a',
      description: 'Reformer pilates ve grup dersleri',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz12',
      name: 'Makyaj Atölyesi',
      category: 'Güzellik Salonu',
      location: 'Nişantaşı',
      address: 'Valikonağı Cad. No:156 Şişli/İstanbul',
      phone: '+90 212 555 12 12',
      email: 'info@makyajatolyesi.com',
      rating: 4.9,
      reviewCount: 321,
      imageUrl: 'https://images.unsplash.com/photo-1487412947147-5cebf100ffc2',
      description: 'Profesyonel makyaj ve makyaj eğitimleri',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz13',
      name: 'Thai Masajı',
      category: 'Spa & Masaj',
      location: 'Sultanahmet',
      address: 'Divanyolu Cad. No:45 Fatih/İstanbul',
      phone: '+90 212 555 13 13',
      email: 'info@thaimasaji.com',
      rating: 4.6,
      reviewCount: 245,
      imageUrl: 'https://images.unsplash.com/photo-1600334129128-685c5582fd35',
      description: 'Geleneksel Thai masaj teknikleri',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz14',
      name: 'Saç Tasarım Stüdyosu',
      category: 'Kuaför & Berber',
      location: 'Bakırköy',
      address: 'Ataköy Sahil Yolu No:234 Bakırköy/İstanbul',
      phone: '+90 212 555 14 14',
      email: 'info@sactasarim.com',
      rating: 4.7,
      reviewCount: 287,
      imageUrl: 'https://images.unsplash.com/photo-1562322140-8baeececf3df',
      description: 'Yaratıcı saç tasarımları ve renklendirme',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz15',
      name: 'Wellness Center',
      category: 'Spa & Masaj',
      location: 'Zorlu Center',
      address: 'Zorlu Center No:1 Beşiktaş/İstanbul',
      phone: '+90 212 555 15 15',
      email: 'info@wellnesscenter.com',
      rating: 4.8,
      reviewCount: 356,
      imageUrl: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef',
      description: 'Tam donanımlı wellness ve spa merkezi',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz16',
      name: 'Kaş & Kirpik Studio',
      category: 'Güzellik Salonu',
      location: 'Suadiye',
      address: 'Suadiye Mah. Bağdat Cad. No:567 Kadıköy/İstanbul',
      phone: '+90 216 555 16 16',
      email: 'info@kaskirpik.com',
      rating: 4.6,
      reviewCount: 198,
      imageUrl: 'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388',
      description: 'Kaş tasarımı ve kirpik uzatma hizmetleri',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz17',
      name: 'Men\'s Spa',
      category: 'Spa & Masaj',
      location: 'Maslak',
      address: 'Maslak Meydan Sok. No:234 Sarıyer/İstanbul',
      phone: '+90 212 555 17 17',
      email: 'info@mensspa.com',
      rating: 4.7,
      reviewCount: 234,
      imageUrl: 'https://images.unsplash.com/photo-1521590832167-7bcbfaa6381f',
      description: 'Erkeklere özel spa ve rahatlama merkezi',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz18',
      name: 'Saç Kaynak Merkezi',
      category: 'Kuaför & Berber',
      location: 'Akmerkez',
      address: 'Akmerkez AVM No:89 Etiler/İstanbul',
      phone: '+90 212 555 18 18',
      email: 'info@sackaynak.com',
      rating: 4.8,
      reviewCount: 289,
      imageUrl: 'https://images.unsplash.com/photo-1560869713-7d0a29430803',
      description: 'Doğal saç kaynak uygulamaları',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz19',
      name: 'Hamam & Kese',
      category: 'Spa & Masaj',
      location: 'Çemberlitaş',
      address: 'Vezirhan Cad. No:12 Fatih/İstanbul',
      phone: '+90 212 555 19 19',
      email: 'info@hamam.com',
      rating: 4.9,
      reviewCount: 567,
      imageUrl: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874',
      description: 'Geleneksel Türk hamamı deneyimi',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz20',
      name: 'Kalıcı Makyaj',
      category: 'Güzellik Salonu',
      location: 'Fulya',
      address: 'Fulya Mah. Büyükdere Cad. No:145 Şişli/İstanbul',
      phone: '+90 212 555 20 20',
      email: 'info@kalicimakyaj.com',
      rating: 4.7,
      reviewCount: 312,
      imageUrl: 'https://images.unsplash.com/photo-1516975080664-ed2fc6a32937',
      description: 'Mikroblading ve kalıcı makyaj uygulamaları',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz21',
      name: 'Kids Kuaför',
      category: 'Kuaför & Berber',
      location: 'Acıbadem',
      address: 'Acıbadem Cad. No:78 Kadıköy/İstanbul',
      phone: '+90 216 555 21 21',
      email: 'info@kidskuafor.com',
      rating: 4.6,
      reviewCount: 167,
      imageUrl: 'https://images.unsplash.com/photo-1606214174585-fe31582dc6ee',
      description: 'Çocuklara özel kuaför hizmetleri',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz22',
      name: 'Refleksoloji Merkezi',
      category: 'Spa & Masaj',
      location: 'Kozyatağı',
      address: 'Kozyatağı Mah. Sarı Kanarya Sok. No:45 Kadıköy/İstanbul',
      phone: '+90 216 555 22 22',
      email: 'info@refleksoloji.com',
      rating: 4.8,
      reviewCount: 198,
      imageUrl: 'https://images.unsplash.com/photo-1519823551278-64ac92734fb1',
      description: 'Refleksoloji ve alternative terapi',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz23',
      name: 'Bridal Beauty',
      category: 'Güzellik Salonu',
      location: 'Şişli',
      address: 'Osmanbey Mah. Halaskargazi Cad. No:123 Şişli/İstanbul',
      phone: '+90 212 555 23 23',
      email: 'info@bridalbeauty.com',
      rating: 4.9,
      reviewCount: 445,
      imageUrl: 'https://images.unsplash.com/photo-1487412947147-5cebf100ffc2',
      description: 'Gelin saçı ve makyajı uzmanı',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz24',
      name: 'Sakal & Bıyık Tasarım',
      category: 'Kuaför & Berber',
      location: 'Ataşehir',
      address: 'Ataşehir Bulvarı No:234 Ataşehir/İstanbul',
      phone: '+90 216 555 24 24',
      email: 'info@sakalbiyi.com',
      rating: 4.7,
      reviewCount: 276,
      imageUrl: 'https://images.unsplash.com/photo-1493256338651-d82f7acb2b38',
      description: 'Sakal ve bıyık şekillendirme uzmanı',
      isActive: true,
    ),
    const BusinessModel(
      id: 'biz25',
      name: 'Aromaterapi & Spa',
      category: 'Spa & Masaj',
      location: 'Moda',
      address: 'Moda Cad. No:89 Kadıköy/İstanbul',
      phone: '+90 216 555 25 25',
      email: 'info@aromaterapi.com',
      rating: 4.8,
      reviewCount: 234,
      imageUrl: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef',
      description: 'Aromaterapi masajları ve doğal ürünler',
      isActive: true,
    ),
  ];
}
