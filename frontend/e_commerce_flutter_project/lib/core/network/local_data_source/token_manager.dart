import '../../constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  final FlutterSecureStorage storage;

  TokenManager({required this.storage});

  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await storage.write(key: Constants.accessTokenKey, value: accessToken);
    await storage.write(key: Constants.refreshTokenKey, value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: Constants.accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: Constants.refreshTokenKey);
  }

  Future<void> clearTokens()async{
    await storage.delete(key: Constants.accessTokenKey);
    await storage.delete(key: Constants.refreshTokenKey);
  }
}