import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';

/// ApiService is an abstract class representing the API service for interacting with the Stack Exchange API.
@ChopperApi(baseUrl: '/api')
abstract class ApiService extends ChopperService {
  /// Create a new instance of ApiService.
  static ApiService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('https://api.stackexchange.com'),
      services: [_$ApiService()],
      converter: const JsonConverter(),
    );
    return _$ApiService(client);
  }

  /// Get a list of posts from the Stack Exchange API.
  @Get(path: '/posts')
  Future<Response<List<dynamic>>> getPosts();

  /// Search for data from the Stack Exchange API.
  @Get(path: '/search')
  Future<Response> searchData({
    @Query('page') int? page,
    @Query('pagesize') int? pageSize,
    @Query('order') String? order,
    @Query('sort') String? sort,
    @Query('tagged') String? tagged,
    @Query('site') String? site,
    @Query('fromdate') int? fromDate,
    @Query('todate') int? toDate,
    @Query('min') int? min,
    @Query('max') int? max,
    @Query('nottagged') String? notTagged,
    @Query('intitle') String? inTitle,
  });

  /// Create a new post via the Stack Exchange API.
  @Post(path: '/posts')
  Future<Response> createPost(@Body() Map<String, dynamic> body);
}

/// _$ApiService is an implementation of ApiService.
class _$ApiService extends ApiService {
  /// Constructor for _$ApiService.
  _$ApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  Future<Response> createPost(Map<String, dynamic> body) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Type get definitionType => ApiService;

  @override
  Future<Response<List>> getPosts() {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<Response> searchData({
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
  }) {
    final StringBuffer endpoint = StringBuffer('/search?');
    if (page != null) endpoint.write('page=$page&');
    if (pageSize != null) endpoint.write('pagesize=$pageSize&');
    if (fromDate != null) endpoint.write('fromdate=$fromDate&');
    if (toDate != null) endpoint.write('todate=$toDate&');
    if (order != null) endpoint.write('order=desc&');
    if (min != null) endpoint.write('min=$min&');
    if (max != null) endpoint.write('max=$max&');
    if (sort != null) endpoint.write('sort=$sort&');
    if (tagged != null) endpoint.write('tagged=$tagged&');
    if (notTagged != null) endpoint.write('nottagged=$notTagged&');
    if (inTitle != null) endpoint.write('intitle=$inTitle&');
    if (site != null) endpoint.write('site=$site');
    debugPrint('${client.baseUrl}$endpoint');
    final Uri url = Uri.parse(endpoint.toString());
    final Request $request = Request(
      'GET',
      url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
