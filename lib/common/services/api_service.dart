import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParams}) async {
    final response = await _dio.get(path, queryParameters: queryParams);
    if (response.statusCode == 200) {
      return response.data['data'];
    } else {
      throw Exception('GET failed');
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
      return response.data;
    } else {
      throw Exception('POST failed');
    }
  }

  Future<Response<T>> put<T>(String path, {dynamic data}) async {
    return _dio.put<T>(path, data: data);
  }

  Future<Response<T>> delete<T>(String path) async {
    return _dio.delete<T>(path);
  }
}
