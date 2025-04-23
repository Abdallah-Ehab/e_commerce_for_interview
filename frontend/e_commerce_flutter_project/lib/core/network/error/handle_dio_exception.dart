import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_flutter_project/core/utils/result.dart';

Result<Response> handleDioExceptions(
  DioException e,
  String endpointName,
  String serviceName,
) {
  log("DioException from $endpointName: ${e.message}", name: serviceName);
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      log('Connection timeout', name: 'DioExceptionType.connectionTimeout');
      return Result.failure(error: ServiceError(message: 'Connection timeout'));

    case DioExceptionType.sendTimeout:
      log('Send timeout', name: 'DioExceptionType.sendTimeout');
      return Result.failure(error: ServiceError(message: 'Send timeout'));

    case DioExceptionType.receiveTimeout:
      log('Receive timeout', name: 'DioExceptionType.receiveTimeout');
      return Result.failure(error: ServiceError(message: 'Receive timeout'));

    case DioExceptionType.badResponse:
      log('Bad response', name: 'DioExceptionType.badResponse');
      return Result.failure(
        error: ServiceError(message: 'Bad response: ${e.response?.statusCode}'),
      );

    case DioExceptionType.cancel:
      log('Request cancelled', name: 'DioExceptionType.cancel');
      return Result.failure(error: ServiceError(message: 'Request cancelled'));

    default:
      log('${e.message}', name: 'DioExceptionType.unknown');
      return Result.failure(
        error: ServiceError(message: 'Unknown error: ${e.message}'),
      );
  }
}
