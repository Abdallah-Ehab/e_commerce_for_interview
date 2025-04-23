import 'package:dio/dio.dart';

import 'package:e_commerce_flutter_project/core/utils/result.dart';
import 'package:e_commerce_flutter_project/features/authentication/domain/repo/auth_repo.dart';
import 'package:e_commerce_flutter_project/features/ensure_logged_in_feature/cubit/ensure_logged_in_cubit.dart';


class RefreshTokenInterceptor extends Interceptor {
  final AuthRepo authRepo;
  final Dio dio;
  final EnsureLoggedInCubit ensureLoggedInCubit;

  RefreshTokenInterceptor({required this.authRepo, required this.dio,required this.ensureLoggedInCubit});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken = await authRepo.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        Result<String> result = await authRepo.refreshAccessToken();
        if (result.error != null) {
          throw Exception(result.error);
        }
        String newAccessToken = result.successData!;
        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        final opts = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        );
        final retryResponse = await dio.request(
          err.requestOptions.path,
          options: opts,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );
        return handler.resolve(retryResponse);
      } catch (e) {
        ensureLoggedInCubit.logOut(); // Logout on failure
        return handler.reject(err);
      }
    }
    super.onError(err, handler);
  }
}