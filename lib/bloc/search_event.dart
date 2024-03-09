part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  execute(SearchBloc searchBloc, Emitter<SearchState> emit);
}


