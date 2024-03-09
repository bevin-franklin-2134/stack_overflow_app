part of 'search_bloc.dart';

/// Class representing the state of a search operation.
class SearchState {
  SearchStatus? status; // Status of the search operation
  SearchResult? result; // Result of the search operation
  String? errorText; // Error message if the search operation fails

  /// Constructor for initializing the search state.
  SearchState({
    this.status = SearchStatus.NONE,
    this.result,
    this.errorText,
  });

  /// Method to create a copy of the current search state with optional modifications.
  SearchState copyWith({
    SearchStatus? status,
    SearchResult? result,
    String? errorText,
  }) {
    return SearchState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorText: errorText ?? this.errorText,
    );
  }
}
