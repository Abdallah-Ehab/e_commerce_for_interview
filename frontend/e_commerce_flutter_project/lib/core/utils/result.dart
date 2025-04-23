class Result<T> {
  final T? successData;
  final ServiceError? error;

  Result.success({this.successData}) : error = null;
  Result.failure({this.error}) : successData = null;
}


class ServiceError{
  final String message;
  final int? statusCode;

  ServiceError({required this.message, this.statusCode});
}