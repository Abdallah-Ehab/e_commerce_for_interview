import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_project/constants.dart';

class AuthServices {
  Future<Result<Response>> registerWithNameEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        '${Constants.mainUrl}register',
        data: {'name': name,'email': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      return Result.success(data: response);
    } on DioException catch (e) {
      if (e.response != null) {
        return Result.failure(error: e.response?.data['message']);
      } else {
        return handleError(e);
      }
    } catch (e) {
      return Result.failure(error: 'An unknown error occurred: $e');
    }
  }

  Future<Result<Response>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        '${Constants.mainUrl}login',
        data: {'email': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      return Result.success(data: response);
    } on DioException catch (e) {
      if (e.response != null) {
        return Result.failure(error: e.response?.data['message']);
      } else {
        return handleError(e);
      }
    } catch (e) {
      return Result.failure(error: 'An unknown error occurred: $e');
    }
  }
}

Result<Response> handleError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return Result.failure(error: 'Connection timeout');

    case DioExceptionType.sendTimeout:
      return Result.failure(error: 'Send timeout');

    case DioExceptionType.receiveTimeout:
      return Result.failure(error: 'Receive timeout');

    case DioExceptionType.badResponse:
      return Result.failure(error: 'Bad response: ${e.response?.statusCode}');

    case DioExceptionType.cancel:
      return Result.failure(error: 'Request cancelled');

    default:
      return Result.failure(error: 'Unknown error: ${e.message}');
  }
}

class Result<T> {
  final T? data;
  final String? error;

  Result.success({this.data}) : error = null;
  Result.failure({this.error}) : data = null;
}
