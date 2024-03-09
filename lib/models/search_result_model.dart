import 'package:stack_overflow_app/models/item_model.dart';

/// A model class representing the search result from a Stack Exchange API response.
class SearchResult {
  List<Items>? _items;
  bool? _hasMore;
  int? _quotaMax;
  int? _quotaRemaining;
  int? _page;

  /// Constructor for the [SearchResult] class.
  SearchResult({
    List<Items>? items,
    bool? hasMore,
    int? quotaMax,
    int? quotaRemaining,
    int? page,
  })  : _items = items,
        _hasMore = hasMore,
        _quotaMax = quotaMax,
        _quotaRemaining = quotaRemaining,
        _page = page;

  /// Constructor for creating [SearchResult] from JSON data.
  SearchResult.fromJson(dynamic json) {
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
    _hasMore = json['has_more'];
    _quotaMax = json['quota_max'];
    _quotaRemaining = json['quota_remaining'];
    _page = json['page'];
  }

  /// Getter for items.
  List<Items>? get items => _items;

  /// Getter for hasMore.
  bool? get hasMore => _hasMore;

  /// Getter for quotaMax.
  int? get quotaMax => _quotaMax;

  /// Getter for quotaRemaining.
  int? get quotaRemaining => _quotaRemaining;

  /// Getter for page.
  int? get page => _page;

  /// Convert [SearchResult] object to JSON.
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    map['has_more'] = _hasMore;
    map['quota_max'] = _quotaMax;
    map['quota_remaining'] = _quotaRemaining;
    map['page'] = _page;
    return map;
  }
}
