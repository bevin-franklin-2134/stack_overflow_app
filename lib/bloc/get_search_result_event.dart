import 'package:bloc/src/bloc.dart'; // Bloc package for state management
import 'package:stack_overflow_app/bloc/search_bloc.dart'; // Importing the search_bloc.dart file for SearchBloc
import 'package:stack_overflow_app/helper/api_helper.dart'; // Importing the api_helper.dart file for making API requests
import 'package:stack_overflow_app/models/item_model.dart'; // Importing the ItemModel class for defining search result items
import 'package:stack_overflow_app/models/search_result_model.dart'; // Importing the SearchResult class for defining search results

/// Event class responsible for fetching search results from an API.
class GetSearchResultEvent extends SearchEvent {
  final String? searchText; // The text to search
  final int? page; // The page number
  final int? pageSize; // The page size
  final String? order; // The order of sorting
  final String? sort; // The field to sort

  /// Constructor to initialize search parameters.
  GetSearchResultEvent({
    this.searchText,
    this.pageSize,
    this.order,
    this.sort,
    this.page,
  });

  @override
  /// Executes the search operation asynchronously.
  ///
  /// This method updates the state of [SearchBloc] based on the result
  /// and emits new states.
  /// - Emits loading state initially.
  /// - Emits success/failure states based on API response.
  /// - Emits a final state with no result.
  execute(SearchBloc searchBloc, Emitter<SearchState> emit) async {
    try {
      emit(searchBloc.state.copyWith(status: SearchStatus.LOADING)); // Emitting loading state

      // Making an API call to fetch search data
      var res = await ApiHelper().searchData(
        page: page,
        inTitle: searchText,
        sort: sort,
        order: order,
        pageSize: pageSize,
      );

      if (res is SearchResult) {
        // Handling search result
        if ((res.page ?? 0) > 1) {
          // If it's not the first page, merge items
          List<Items> items = [];
          items.addAll(searchBloc.state.result?.items ?? []);
          items.addAll(res.items ?? []);
          SearchResult result = SearchResult(
            items: items,
            page: res.page,
            hasMore: res.hasMore,
            quotaMax: res.quotaMax,
            quotaRemaining: res.quotaRemaining,
          );
          emit(searchBloc.state.copyWith(
            status: SearchStatus.SUCCESS,
            result: result,
          ));
        } else {
          // If it's the first page, emit result directly
          emit(searchBloc.state.copyWith(
            status: SearchStatus.SUCCESS,
            result: res,
          ));
        }
      } else if (res is String) {
        // Handling error response
        emit(searchBloc.state.copyWith(
          status: SearchStatus.FAIL,
          errorText: res,
          result: null,
        ));
      }
    } catch (e) {
      // Catching and handling exceptions
      emit(searchBloc.state.copyWith(
        status: SearchStatus.FAIL,
        errorText: e.toString(),
        result: null,
      ));
    }
    emit(searchBloc.state.copyWith(
      status: SearchStatus.NONE,
      result: null,
    )); // Emitting final state
  }
}
