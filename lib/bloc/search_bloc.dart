import 'dart:async'; // Importing asynchronous utilities

import 'package:flutter/material.dart'; // Importing Flutter material library
import 'package:flutter_bloc/flutter_bloc.dart'; // Importing Flutter BLoC library
import 'package:stack_overflow_app/models/search_result_model.dart'; // Importing SearchResult model

part 'search_event.dart'; // Importing SearchEvent part file
part 'search_state.dart'; // Importing SearchState part file

/// BLoC class responsible for managing search functionality.
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  /// Constructor for initializing the search BLoC.
  SearchBloc() : super(SearchState()) {
    on<SearchEvent>(_onSearchEvent); // Listening to SearchEvent and invoking _onSearchEvent
  }

  /// Callback function to handle search events.
  FutureOr<void> _onSearchEvent(SearchEvent event, Emitter<SearchState> emit) async {
    await event.execute(this, emit); // Executing the search event
  }
}

/// Enumeration representing the status of a search operation.
enum SearchStatus {
  NONE, // No search operation
  LOADING, // Loading search results
  SUCCESS, // Successful search operation
  FAIL, // Failed search operation
}
