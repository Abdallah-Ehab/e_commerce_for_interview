import 'package:e_commerce_flutter_project/core/utils/result.dart';

abstract class AuthRepo {
  Future<Result<String>> registerWithNameEmailAndPassword(String name, String email, String password);
  Future<Result<String>> loginWithEmailAndPassword(String email, String password);
  Future<Result<String>> refreshAccessToken();
  Future<void> saveTokens({required String accessToken, required String refreshToken});
  Future<void> clearTokens();
  Future<String?> getAccessToken();
  Future<Result<bool>> ensureLoggedIn();
  Future<void> logOut();
}