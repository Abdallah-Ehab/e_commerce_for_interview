import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_project/core/constants.dart';
import 'package:e_commerce_flutter_project/core/network/clients/dio_client.dart';
import 'package:e_commerce_flutter_project/core/network/error/handle_dio_exception.dart';
import 'package:e_commerce_flutter_project/core/utils/result.dart';


// the auth service uses authentication dio client instance without any interceptors
//because really you don't need an interceptor may be an interceptor for error handling which is really not traditional
//but you don't need an interceptor for refresh token for sure

class AuthServices {
  final DioClient authClient;

  AuthServices({required this.authClient});

  Future<Result<Response>> _postRequestHelper({
    required String path,
    required dynamic data,
    required String endpointName,
  }) async {
    try {
      Response response = await authClient.post(
        path: path,
        data: data,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return Result.success(successData: response);
    } on DioException catch (e) {
      log(
        e.response?.data['message'] ?? "No error message from $endpointName",
        name: 'AuthServices',
      );
      if (e.response != null) {
        return Result.failure(
          error: ServiceError(
            message: e.response?.data['message'] ?? "No error message from $endpointName",
            statusCode: e.response?.statusCode,
          ),
        );
      } else {
        return handleDioExceptions(e,endpointName,"AuthService");
      }
    } catch (e) {
      log("Unknown error from $endpointName: $e", name: 'AuthServices');
      return Result.failure(
        error: ServiceError(
          message: "$e: Unknown error from $endpointName",
        ),
      );
    }
  }

  Future<Result<Response>> registerWithNameEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    return await _postRequestHelper(
      path: '${Constants.mainUrl}${Constants.registerEndPoint}',
      data: {'username': name, 'email': email, 'password': password},
      endpointName: '/registerUser',
    );
  }

  Future<Result<Response>> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _postRequestHelper(
      path: '${Constants.mainUrl}${Constants.loginEndPoint}',
      data: {'email': email, 'password': password},
      endpointName: '/login',
    );
  }

  Future<Result<Response>> fetchNewAccessToken(String refreshToken) async {
    return await _postRequestHelper(
      path: '${Constants.mainUrl}${Constants.refreshTokenEndPoint}',
      data: {'refresh_token': refreshToken},
      endpointName: '/refresh',
    );
  }
}
