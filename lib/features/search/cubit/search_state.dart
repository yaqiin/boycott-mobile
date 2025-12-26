part of 'search_cubit.dart';

sealed class SearchState {
  const SearchState();
}

class SearchIdle extends SearchState {
  const SearchIdle();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchSuccess extends SearchState {
  const SearchSuccess({
    required this.results,
    required this.currentPage,
    required this.hasNextPage,
    required this.query,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<BoycottCompany> results;
  final int currentPage;
  final bool hasNextPage;
  final String query;
  final bool isLoadingMore;
  final String? loadMoreError;

  SearchSuccess copyWith({
    List<BoycottCompany>? results,
    int? currentPage,
    bool? hasNextPage,
    bool? isLoadingMore,
    Object? loadMoreError = _sentinel,
  }) {
    return SearchSuccess(
      results: results ?? this.results,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      query: query,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreError: identical(loadMoreError, _sentinel)
          ? this.loadMoreError
          : loadMoreError as String?,
    );
  }

  static const _sentinel = Object();
}

class SearchFailure extends SearchState {
  const SearchFailure(this.message);

  final String message;
}
