import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParams}) async {
    final response = await _dio.get(path, queryParameters: queryParams);

    if (response.statusCode == 200) {
      final dynamic resp = response.data!;
      return resp['data'];
    } else {
      throw Exception('Failed to fetch properties');
    }
  }

  Future<dynamic> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParams,
    );
    if (response.statusCode == 200) {
      final dynamic resp = response.data!;
      return resp;
    } else {
      throw Exception('Failed to fetch properties');
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) async {
    return _dio.put<T>(path, data: data, queryParameters: queryParams);
  }

  Future<Response<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    return _dio.delete<T>(path, queryParameters: queryParams);
  }
}
