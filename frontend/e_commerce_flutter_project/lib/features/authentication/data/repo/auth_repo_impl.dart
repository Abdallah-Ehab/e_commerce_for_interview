import 'package:dio/dio.dart' as dio;
import 'package:e_commerce_flutter_project/core/constants.dart';
import 'package:e_commerce_flutter_project/core/utils/result.dart';
import 'package:e_commerce_flutter_project/features/authentication/data/services/auth_services.dart';
import '../../../../core/network/local_data_source/token_manager.dart';
import 'package:e_commerce_flutter_project/features/authentication/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthServices authServices;
  final TokenManager tokenManager;

  AuthRepoImpl({required this.authServices, required this.tokenManager});

  Future<Result<String>> _handleAuthRequestHelper({
    required Future<Result<dio.Response>> Function() request,
    required String endpointName,
    String? message,
  }) async {
    Result<dio.Response> result = await request();
    if (result.error != null) {
      switch (result.error!.statusCode) {
        case 409:
          return Result.failure(error: ServiceError(message: "User already exists with this email"));
        case 422:
          return Result.failure(error: ServiceError(message: "Email or password is not valid"));
        case 401:
          return Result.failure(error: ServiceError(message: "Invalid credentials"));
        default:
          return Result.failure(
            error: ServiceError(message: "Unknown error occurred in $endpointName"),
          );
      }
    }
    final responseData = result.successData!.data as Map<String, dynamic>;
    await fetchUserAndSaveTokensHelper(responseData);
    return Result.success(successData: message);
  }

  Future<void> fetchUserAndSaveTokensHelper(Map<String, dynamic> responseData) async {
    final String? accessToken = responseData[Constants.apiAccessTokenName];
    final String? refreshToken = responseData[Constants.apiRefreshTokenName];
    if (accessToken != null && refreshToken != null) {
      await saveTokens(accessToken: accessToken, refreshToken: refreshToken);
    }

  }

  @override
  Future<Result<String>> registerWithNameEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    return await _handleAuthRequestHelper(
      request: () => authServices.registerWithNameEmailAndPassword(name, email, password),
      endpointName: 'register',
      message: "User registered successfully",
    );
  }

  @override
  Future<Result<String>> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _handleAuthRequestHelper(
      request: () => authServices.loginWithEmailAndPassword(email, password),
      endpointName: 'login',
      message: "User logged in successfully",
    );
  }

  @override
  Future<Result<String>> refreshAccessToken() async {
    String? oldRefreshToken = await tokenManager.getRefreshToken();
    if (oldRefreshToken == null) {
      return Result.failure(error: ServiceError(message: "No refresh token available"));
    }
    Result<dio.Response> result = await authServices.fetchNewAccessToken(oldRefreshToken);
    if (result.error != null) {
      switch (result.error!.statusCode) {
        case 403:
          return Result.failure(error: ServiceError(message: "Invalid or expired refresh token"));
        default:
          return Result.failure(
            error: ServiceError(message: "Unknown error occurred in refresh"),
          );
      }
    }
    final responseData = result.successData!.data as Map<String, dynamic>;
    fetchUserAndSaveTokensHelper(responseData);
    return Result.success(successData: "refresh token successfully");
  }

  @override
  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await tokenManager.saveTokens(accessToken: accessToken, refreshToken: refreshToken);
  }

  @override
  Future<void> clearTokens() async {
    await tokenManager.clearTokens();
  }

  @override
  Future<String?> getAccessToken() async {
    return await tokenManager.getAccessToken();
  }
  
  @override
  Future<Result<bool>> ensureLoggedIn()async {
    String? accessToken = await getAccessToken();
    if(accessToken != null){
      return Result.success(successData: true);
    }else{
      return Result.success(successData: false);
    }
  }
  
  @override
  Future<void> logOut() async{
    await tokenManager.clearTokens();
  }
}
