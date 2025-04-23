import 'dart:developer';

import 'package:dio/dio.dart';
import 'dio_client.dart';

class AuthenticationClient extends DioClient {
  AuthenticationClient({required super.interceptors});

 
  @override
  Future<Response> post({required String path,dynamic data, Options? options}) async{
    try {
      final response = await dio.post(path, data: data, options: options);
      return response;
    } on DioException catch (_) {
      rethrow;
    }catch(e){
      log("Error from authentication dio client");
      throw Exception('An unknown error occurred: $e');
    }
   
  }

}