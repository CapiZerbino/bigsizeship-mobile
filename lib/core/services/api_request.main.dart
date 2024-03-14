part of 'api_request.dart';

class GetListResponse {
  GetListResponse({
    required this.data,
    required this.page,
    required this.pageCount,
    required this.total,
  });
  factory GetListResponse.fromJson(DataMap json) {
    return GetListResponse(
      data: json['data'] as List<dynamic>,
      page: json['meta']['pagination']['page'] as int,
      pageCount: json['meta']['pagination']['pageCount'] as int,
      total: json['meta']['pagination']['total'] as int,
    );
  }
  final List<dynamic> data;
  final int page;
  final int pageCount;
  final int total;
}

class CustomResponse<T> {
  CustomResponse({
    required this.data,
    required this.meta,
  });
  factory CustomResponse.fromJson(DataMap json) {
    return CustomResponse<T>(
      data: _parseData(json['data']) as T,
      meta: json['meta'] as DataMap,
    );
  }

  static dynamic _parseData(dynamic data) {
    if (data is List) {
      return List<Map<String, dynamic>>.from(data.cast<Map<String, dynamic>>());
    }
    return data;
  }

  final T data;
  final DataMap meta;
}

// Singleton
class ApiRequest {
  factory ApiRequest() {
    return _instance;
  }
  ApiRequest._internal() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await loadToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
    _dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
  }
  final Dio _dio = Dio();
  static final ApiRequest _instance = ApiRequest._internal();

  Future<GetListResponse> getList({
    required String resource,
    required Pagination pagination,
    required CrudFilters filters,
    required CrudSorting sorters,
  }) async {
    final url = '$kBaseUrl/$resource';

    final querySorters = generateSort(sorters);
    final queryFilters = generateFilter(filters);

    final queryParams = {
      if (pagination.mode == 'server') ...{
        'pagination[page]': pagination.current.toString(),
        'pagination[pageSize]': pagination.pageSize.toString(),
      },
      if (sorters.isNotEmpty) ...{
        'sort': querySorters.isNotEmpty ? querySorters.join(',') : '',
      },
    };

    final response = await _dio.get<DataMap>(
      url,
      data: queryFilters,
      queryParameters: queryParams,
      options: Options(
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return GetListResponse.fromJson(response.data!);
    } else {
      throw ApiException(
        message: response.statusMessage ?? 'Unknown error',
        statusCode: response.statusCode ?? 500,
      );
    }
  }

  Future<T> create<T>({
    required String resource,
    required Map<String, dynamic> payload,
  }) async {
    final url = '$kBaseUrl/$resource';

    final response = await _dio.post<DataMap>(
      url,
      data: {'data': payload},
      options: Options(
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data! as T;
    } else {
      throw ApiException(
        message: response.statusMessage ?? 'Unknown error',
        statusCode: response.statusCode ?? 500,
      );
    }
  }

  Future<CustomResponse<Type>> custom<Type>({
    required String url,
    required String method,
    required CrudFilters filters,
    required CrudSorting sorters,
    required Map<String, dynamic> headers,
    dynamic payload,
    required Map<String, dynamic> query,
  }) async {
    var requestUrl = '$url?';

    if (sorters.isNotEmpty) {
      final sortQuery = generateSort(sorters);
      requestUrl = '$requestUrl&${sortQuery.join(',')}';
    }

    if (filters.isNotEmpty) {
      final filterQuery = generateFilter(filters);
      requestUrl = '$requestUrl&$filterQuery';
    }

    _dio.options.headers = {
      ..._dio.options.headers,
      ...headers,
    };

    final response = await _dio.request<DataMap>(
      requestUrl,
      data: payload,
      queryParameters: query,
      options: Options(
        method: method,
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      return CustomResponse<Type>.fromJson(response.data!);
    } else {
      throw ApiException(
        message: response.statusMessage ?? 'Unknown error',
        statusCode: response.statusCode ?? 500,
      );
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  Future<String?> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }
}
