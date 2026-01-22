import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/business_model.dart';
import '../../repositories/business_repository_factory.dart';
import '../storage_providers.dart';

class DiscoverState {
  final List<BusinessModel> businesses;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final int page;
  final String? category;
  final String? searchQuery;

  DiscoverState({
    required this.businesses,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
    this.page = 1,
    this.category,
    this.searchQuery,
  });

  DiscoverState copyWith({
    List<BusinessModel>? businesses,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    int? page,
    String? category,
    String? searchQuery,
  }) {
    return DiscoverState(
      businesses: businesses ?? this.businesses,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error:
          error, // Can't be handled easily if we want to null it, keeping it simple
      page: page ?? this.page,
      category: category ?? this.category,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class DiscoverNotifier extends StateNotifier<DiscoverState> {
  final IBusinessRepository _repository;
  static const int pageSize = 10;

  DiscoverNotifier(this._repository) : super(DiscoverState(businesses: [])) {
    loadBusinesses();
  }

  Future<void> loadBusinesses({String? category, bool isRefresh = true}) async {
    if (isRefresh) {
      state = state.copyWith(
          isLoading: true,
          page: 1,
          businesses: [],
          hasMore: true,
          category: category);
    } else {
      if (!state.hasMore || state.isLoadingMore) return;
      state = state.copyWith(isLoadingMore: true);
    }

    try {
      final offset = (state.page - 1) * pageSize;
      final result = await _repository.getBusinesses(
        category: category ?? state.category,
        searchQuery: state.searchQuery,
        limit: pageSize,
        offset: offset,
      );

      result.when(
        success: (businesses) {
          final updatedBusinesses =
              isRefresh ? businesses : [...state.businesses, ...businesses];
          state = state.copyWith(
            businesses: updatedBusinesses,
            isLoading: false,
            isLoadingMore: false,
            hasMore: businesses.length == pageSize,
            page: state.page + 1,
          );
        },
        failure: (error) {
          state = state.copyWith(
            isLoading: false,
            isLoadingMore: false,
            error: error.toString(),
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadNextPage() async {
    await loadBusinesses(isRefresh: false);
  }

  Future<void> searchBusinesses(String query) async {
    state = state.copyWith(
        searchQuery: query, page: 1, businesses: [], hasMore: true);
    await loadBusinesses(isRefresh: true);
  }

  Future<void> filterByCategory(String category) async {
    final cat = category == 'Tümü' ? null : category;
    await loadBusinesses(category: cat, isRefresh: true);
  }

  Future<BusinessModel?> getBusinessById(String id) async {
    try {
      final result = await _repository.getBusinessById(id);
      return result.when(
        success: (business) => business,
        failure: (_) => null,
      );
    } catch (e) {
      return null;
    }
  }
}

final discoverProvider = StateNotifierProvider<DiscoverNotifier, DiscoverState>(
  (ref) {
    final cacheManager = ref.watch(cacheManagerProvider);
    final repository = BusinessRepositoryFactory.create(
      cacheManager: cacheManager,
    );
    return DiscoverNotifier(repository);
  },
);
