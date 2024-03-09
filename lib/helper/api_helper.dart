import 'dart:convert'; // Importing Dart's convert library for JSON encoding/decoding

import 'package:flutter/cupertino.dart'; // Importing Flutter's Cupertino library
import 'package:stack_overflow_app/helper/chopper_helper.dart'; // Importing the Chopper helper
import 'package:stack_overflow_app/models/search_result_model.dart'; // Importing the SearchResult model

/// Helper class for making API requests.
class ApiHelper {
  final ApiService _apiService = ApiService.create(); // Creating an instance of ApiService

  /// Method to search data from the API.
  ///
  /// Parameters:
  /// - [page] => Page number for pagination (optional, default is 1).
  /// - [pageSize]=> Number of items per page (optional).
  /// - [order]=> Order of sorting (optional).
  /// - [sort]=> Field to sort by (optional).
  /// - [tagged]=> Tags to filter by (optional).
  /// - [site]=> Site to search on (optional).
  /// - [fromDate]=> Minimum date (optional).
  /// - [toDate]=> Maximum date (optional).
  /// - [min]=> Minimum value (optional).
  /// - [max]=> Maximum value (optional).
  /// - [notTagged]=> Tags to exclude (optional).
  /// - [inTitle]=> Text to search for in titles (optional).
  Future<dynamic> searchData({
    int? page,
    int? pageSize,
    String? order,
    String? sort,
    String? tagged,
    String? site,
    int? fromDate,
    int? toDate,
    int? min,
    int? max,
    String? notTagged,
    String? inTitle,
  }) async {
    try {
      var res = await _apiService.searchData(
        site: 'stackoverflow',
        page: page ?? 1,
        inTitle: inTitle,
        pageSize: pageSize,
        sort: sort,
        order: order,
      );

      if (res.isSuccessful) {
        // Parsing the successful response
        var response = json.decode(res.bodyString);
        var data = SearchResult.fromJson(response);
        debugPrint('API Success: $data');

        // Returning the parsed search result
        return SearchResult(
          page: page,
          items: data.items,
          hasMore: data.hasMore,
          quotaRemaining: data.quotaRemaining,
          quotaMax: data.quotaMax,
        );
      } else {
        // Handling unsuccessful response
        var message = json.decode(res.error.toString())['error_message'];
        debugPrint('API Error: $message');
        return message;
      }
    } catch (e) {
      // Catching and rethrowing exceptions
      debugPrint('API Exception: $e');
      rethrow;
    }
  }
}
