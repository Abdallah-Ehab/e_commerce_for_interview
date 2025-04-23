import 'package:dio/dio.dart';
import 'dio_client.dart';

class ProductClient extends DioClient{
  
  ProductClient({required super.interceptors});

  @override
  Future<Response> get({required String path, Options? options,Map<String,dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, options: options, queryParameters: queryParameters);
      return response;
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      throw Exception('An unknown error in product client occurred: $e');
    }
  }
  
}