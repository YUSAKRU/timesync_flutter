import 'dart:math';

import '../../models/review_model.dart';
import '../result.dart';

/// Mock Review Repository
/// Simulates API calls for review management
class MockReviewRepository {
  final _random = Random();

  // Simulate network delay
  Future<void> _delay() async {
    await Future.delayed(Duration(milliseconds: 300 + _random.nextInt(700)));
  }

  /// Get reviews for a business
  Future<Result<List<ReviewModel>>> getBusinessReviews({
    required String businessId,
    int? rating,
    int limit = 20,
  }) async {
    try {
      await _delay();

      var reviews =
          _mockReviews.where((r) => r.businessId == businessId).toList();

      // Apply rating filter
      if (rating != null) {
        reviews = reviews.where((r) => r.rating == rating).toList();
      }

      // Sort by date (newest first)
      reviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return Result.success(reviews.take(limit).toList());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get reviews by customer
  Future<Result<List<ReviewModel>>> getCustomerReviews(
      String customerId) async {
    try {
      await _delay();

      final reviews =
          _mockReviews.where((r) => r.customerId == customerId).toList();

      // Sort by date (newest first)
      reviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return Result.success(reviews);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get review by ID
  Future<Result<ReviewModel>> getReviewById(String id) async {
    try {
      await _delay();

      final review = _mockReviews.firstWhere(
        (r) => r.id == id,
        orElse: () => throw Exception('Yorum bulunamadı'),
      );

      return Result.success(review);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Create new review
  Future<Result<ReviewModel>> createReview({
    required String businessId,
    required String customerId,
    required String customerName,
    required String appointmentId,
    required double rating,
    required String comment,
    String? customerPhotoUrl,
    List<String>? images,
  }) async {
    try {
      await _delay();

      final newReview = ReviewModel(
        id: 'rev_${DateTime.now().millisecondsSinceEpoch}',
        businessId: businessId,
        customerId: customerId,
        customerName: customerName,
        customerPhotoUrl: customerPhotoUrl,
        appointmentId: appointmentId,
        rating: rating,
        title: 'Harika!',
        comment: comment,
        images: images,
        createdAt: DateTime.now(),
        isVerified: true,
        isPublished: true,
      );

      return Result.success(newReview);
    } catch (e) {
      return Result.failure('Yorum eklenemedi: ${e.toString()}');
    }
  }

  /// Add business response to review
  Future<Result<ReviewModel>> addResponse({
    required String reviewId,
    required String response,
  }) async {
    try {
      await _delay();

      final review = _mockReviews.firstWhere(
        (r) => r.id == reviewId,
        orElse: () => throw Exception('Yorum bulunamadı'),
      );

      final updatedReview = review.copyWith(
        businessResponse: response,
        businessResponseDate: DateTime.now(),
      );

      return Result.success(updatedReview);
    } catch (e) {
      return Result.failure('Yanıt eklenemedi: ${e.toString()}');
    }
  }

  /// Delete review
  Future<Result<bool>> deleteReview(String reviewId) async {
    try {
      await _delay();

      final exists = _mockReviews.any((r) => r.id == reviewId);
      if (!exists) {
        throw Exception('Yorum bulunamadı');
      }

      return Result.success(true);
    } catch (e) {
      return Result.failure('Yorum silinemedi: ${e.toString()}');
    }
  }

  /// Get review statistics for business
  Future<Result<Map<String, dynamic>>> getReviewStats(String businessId) async {
    try {
      await _delay();

      final reviews =
          _mockReviews.where((r) => r.businessId == businessId).toList();

      if (reviews.isEmpty) {
        return Result.success({
          'totalReviews': 0,
          'averageRating': 0.0,
          'ratingDistribution': {5: 0, 4: 0, 3: 0, 2: 0, 1: 0},
        });
      }

      final totalRating = reviews.fold<double>(0, (sum, r) => sum + r.rating);
      final avgRating = totalRating / reviews.length;

      final distribution = <int, int>{5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
      for (var review in reviews) {
        distribution[review.rating.toInt()] =
            (distribution[review.rating.toInt()] ?? 0) + 1;
      }

      return Result.success({
        'totalReviews': reviews.length,
        'averageRating': avgRating,
        'ratingDistribution': distribution,
      });
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  // Mock reviews
  final List<ReviewModel> _mockReviews = [
    ReviewModel(
      id: 'rev1',
      businessId: 'biz1',
      customerId: 'user1',
      customerName: 'Ahmet Yılmaz',
      customerPhotoUrl: 'https://i.pravatar.cc/150?img=11',
      appointmentId: 'apt6',
      rating: 5.0,
      title: 'Harika Hizmet',
      comment:
          'Muhteşem bir hizmet aldım. Mehmet Usta gerçekten çok iyi, ellerine sağlık!',
      createdAt: DateTime.now().subtract(const Duration(days: 14)),
      isVerified: true,
      isPublished: true,
      businessResponse:
          'Teşekkür ederiz! Sizi tekrar görmekten mutluluk duyarız.',
      businessResponseDate: DateTime.now().subtract(const Duration(days: 13)),
    ),
    ReviewModel(
      id: 'rev2',
      businessId: 'biz2',
      customerId: 'user2',
      customerName: 'Mehmet Kaya',
      customerPhotoUrl: 'https://i.pravatar.cc/150?img=12',
      appointmentId: 'apt7',
      rating: 5.0,
      title: 'Çok Memnunum',
      comment:
          'Cilt bakımı için gittim, sonuçtan çok memnunum. Zeynep Hanım çok profesyonel.',
      createdAt: DateTime.now().subtract(const Duration(days: 29)),
      isVerified: true,
      isPublished: true,
    ),
    ReviewModel(
      id: 'rev3',
      businessId: 'biz1',
      customerId: 'user3',
      customerName: 'Fatma Şahin',
      customerPhotoUrl: 'https://i.pravatar.cc/150?img=5',
      appointmentId: 'apt4',
      rating: 4.0,
      title: 'Güzel Sonuç',
      comment:
          'Saç boyamam çok güzel oldu, tek eksi bekleme süresi biraz uzundu.',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      isVerified: true,
      isPublished: true,
      businessResponse:
          'Geri bildiriminiz için teşekkürler, bekleme sürelerini kısaltmak için çalışıyoruz.',
      businessResponseDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
    ReviewModel(
      id: 'rev4',
      businessId: 'biz3',
      customerId: 'user3',
      customerName: 'Fatma Şahin',
      customerPhotoUrl: 'https://i.pravatar.cc/150?img=5',
      appointmentId: 'apt9',
      rating: 5.0,
      title: 'Harika Masaj',
      comment:
          'Aromaterapi masajı harikaydı, stresim tamamen yok oldu. Ali Bey çok ilgili.',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      isVerified: true,
      isPublished: true,
    ),
    ReviewModel(
      id: 'rev5',
      businessId: 'biz5',
      customerId: 'user1',
      customerName: 'Ahmet Yılmaz',
      customerPhotoUrl: 'https://i.pravatar.cc/150?img=11',
      appointmentId: 'apt8',
      rating: 4.5,
      title: 'Mükemmel Tıraş',
      comment: 'Klasik berberin güzel bir örneği. Sakal tıraşı mükemmeldi.',
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      isVerified: true,
      isPublished: true,
    ),
    ReviewModel(
      id: 'rev6',
      businessId: 'biz1',
      customerId: 'user4',
      customerName: 'Ayşe Demir',
      customerPhotoUrl: 'https://i.pravatar.cc/150?img=8',
      appointmentId: 'apt12',
      rating: 5.0,
      title: 'Tavsiye Ederim',
      comment: 'İlk kez geldim ve çok beğendim. Kesinlikle tavsiye ederim!',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      isVerified: true,
      isPublished: true,
    ),
    ReviewModel(
      id: 'rev7',
      businessId: 'biz2',
      customerId: 'user5',
      customerName: 'Elif Yıldız',
      customerPhotoUrl: 'https://i.pravatar.cc/150?img=17',
      appointmentId: 'apt13',
      rating: 4.5,
      title: 'Hijyenik Salon',
      comment: 'Manikür ve pedikür için gittim. Salon çok temiz ve hijyenik.',
      createdAt: DateTime.now().subtract(const Duration(days: 35)),
      isVerified: true,
      isPublished: true,
    ),
    ReviewModel(
      id: 'rev8',
      businessId: 'biz4',
      customerId: 'user1',
      customerName: 'Ahmet Yılmaz',
      customerPhotoUrl: 'https://i.pravatar.cc/150?img=11',
      appointmentId: 'apt5',
      rating: 3.5,
      title: 'İyi Hizmet',
      comment:
          'İyi ama beklentimin biraz altındaydı. Selin Hanım gayet nazikti.',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      isVerified: true,
      isPublished: true,
    ),
    ReviewModel(
      id: 'rev9',
      businessId: 'biz6',
      customerId: 'user6',
      customerName: 'Can Arslan',
      customerPhotoUrl: 'https://i.pravatar.cc/150?img=18',
      appointmentId: 'apt14',
      rating: 5.0,
      title: 'Profesyonel Doktor',
      comment:
          'Lazer tedavisi için Dr. Aylin ile görüştüm. Çok profesyonel ve bilgili.',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      isVerified: true,
      isPublished: true,
      businessResponse: 'Değerli yorumunuz için teşekkürler!',
      businessResponseDate: DateTime.now().subtract(const Duration(days: 9)),
    ),
    ReviewModel(
      id: 'rev10',
      businessId: 'biz7',
      customerId: 'user7',
      customerName: 'Zehra Güneş',
      customerPhotoUrl: 'https://i.pravatar.cc/150?img=20',
      appointmentId: 'apt15',
      rating: 5.0,
      title: 'Harika Yoga',
      comment: 'Yoga dersleri harika! Elif Öğretmen çok tecrübeli ve sabırlı.',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      isVerified: true,
      isPublished: true,
    ),
  ];
}
