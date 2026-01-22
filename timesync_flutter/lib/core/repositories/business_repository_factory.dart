import '../../data/models/business_model.dart';
import '../../data/repositories/api/api_business_repository.dart';
import '../../data/repositories/mock/mock_business_repository.dart';
import '../../data/repositories/result.dart';
import '../config/app_environment.dart';
import '../storage/cache_manager.dart';

/// Business Repository Factory
/// Returns mock or API repository based on environment
abstract class IBusinessRepository {
  Future<Result<List<BusinessModel>>> getBusinesses({
    String? category,
    String? searchQuery,
    int? limit,
    int? offset,
  });

  Future<Result<BusinessModel>> getBusinessById(String id);

  Future<Result<List<BusinessModel>>> getFeaturedBusinesses({int limit = 5});

  Future<Result<List<BusinessModel>>> searchBusinesses({
    required String query,
    String? category,
    double? latitude,
    double? longitude,
    double? radius,
  });
}

class BusinessRepositoryFactory {
  static IBusinessRepository create({CacheManager? cacheManager}) {
    if (AppEnvironment.useMockData) {
      // Cast to interface to satisfy type checker
      final repo = MockBusinessRepository(cacheManager: cacheManager);
      return _MockBusinessRepositoryAdapter(repo);
    } else {
      return _ApiBusinessRepositoryAdapter(cacheManager: cacheManager);
    }
  }
}

/// Adapter to make MockBusinessRepository implement IBusinessRepository
class _MockBusinessRepositoryAdapter implements IBusinessRepository {
  final MockBusinessRepository _mock;

  _MockBusinessRepositoryAdapter(this._mock);

  @override
  Future<Result<List<BusinessModel>>> getBusinesses({
    String? category,
    String? searchQuery,
    int? limit,
    int? offset,
  }) =>
      _mock.getBusinesses(category: category, searchQuery: searchQuery);

  @override
  Future<Result<BusinessModel>> getBusinessById(String id) =>
      _mock.getBusinessById(id);

  @override
  Future<Result<List<BusinessModel>>> getFeaturedBusinesses({int limit = 5}) =>
      _mock.getFeaturedBusinesses(limit: limit);

  @override
  Future<Result<List<BusinessModel>>> searchBusinesses({
    required String query,
    String? category,
    double? latitude,
    double? longitude,
    double? radius,
  }) {
    // Mock doesn't have this method yet, use getBusinesses
    return _mock.getBusinesses(searchQuery: query, category: category);
  }
}

// Adapter to match interface
class _ApiBusinessRepositoryAdapter implements IBusinessRepository {
  final ApiBusinessRepository _repo;

  _ApiBusinessRepositoryAdapter({CacheManager? cacheManager})
      : _repo = ApiBusinessRepository(cacheManager: cacheManager);

  @override
  Future<Result<List<BusinessModel>>> getBusinesses({
    String? category,
    String? searchQuery,
    int? limit,
    int? offset,
  }) {
    return _repo.getBusinesses(
      category: category,
      searchQuery: searchQuery,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<Result<BusinessModel>> getBusinessById(String id) {
    return _repo.getBusinessById(id);
  }

  @override
  Future<Result<List<BusinessModel>>> getFeaturedBusinesses({int limit = 5}) {
    return _repo.getFeaturedBusinesses(limit: limit);
  }

  @override
  Future<Result<List<BusinessModel>>> searchBusinesses({
    required String query,
    String? category,
    double? latitude,
    double? longitude,
    double? radius,
  }) {
    return _repo.searchBusinesses(
      query: query,
      category: category,
      latitude: latitude,
      longitude: longitude,
      radius: radius,
    );
  }
}
