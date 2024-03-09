import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stack_overflow_app/bloc/search_bloc.dart';
import 'package:stack_overflow_app/helper/nav_observer.dart';

/// Formats a duration from a [timestamp] in milliseconds since epoch.
///
/// Returns a string representing the formatted date and time.
String formatDurationFromTimestamp(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  String formattedDate = DateFormat.yMMMd().format(dateTime);
  String formattedTime = DateFormat.Hm().format(dateTime);
  return '$formattedDate at $formattedTime';
}

/// A list of pending Google Fonts to be loaded.
Future<List<void>> googleFontsPending = GoogleFonts.pendingFonts([
  GoogleFonts.sourceSans3(),
]);

/// Retrieves the [SearchBloc] instance from the current context.
///
/// Returns the [SearchBloc] instance if available, otherwise returns `null`.
SearchBloc? getSearchBloc() {
  if (NavObserver.navKey.currentContext != null) {
    return NavObserver.navKey.currentContext!.read<SearchBloc>();
  }
  return null;
}
