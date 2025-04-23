import 'package:dio/dio.dart';
import '../../constants.dart';


abstract class DioClient {
  List<Interceptor> interceptors;
  late Dio dio;

  DioClient({required this.interceptors}) {
    dio = Dio(BaseOptions(
      baseUrl: Constants.mainUrl,
      connectTimeout: Duration(seconds: 15),
      receiveTimeout: Duration(seconds: 15),
    ));
    dio.interceptors.addAll(interceptors);
  }

  Future<Response> get({required String path, Options? options, Map<String, dynamic>? queryParameters}) {
    throw UnimplementedError("GET not implemented for this client");
  }

  Future<Response> post({required String path, Options? options, dynamic data}) {
    throw UnimplementedError("POST not implemented for this client");
  }

  Future<Response> put({required String path, Options? options, dynamic data}) {
    throw UnimplementedError("PUT not implemented for this client");
  }

  Future<Response> delete({required String path, Options? options}) {
    throw UnimplementedError("DELETE not implemented for this client");
  }
}