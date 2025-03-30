import 'package:dio/dio.dart' as dio;
import 'package:e_commerce_flutter_project/authentication/data/models/user_model.dart';
import 'package:e_commerce_flutter_project/authentication/data/services/auth_services.dart';
import 'package:e_commerce_flutter_project/authentication/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthServices authServices;
  AuthRepoImpl({required this.authServices});

  @override
  Future<Result<UserModel>> signUpWithNameEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    Result respose = await authServices.registerWithNameEmailAndPassword(
      name,
      email,
      password,
    );
    if (respose.error != null) {
      return Result.failure(error: respose.error);
    } else {
      final responceData = respose.data as dio.Response;
      UserModel userModel = UserModel.fromJson(responceData.data);
      return Result.success(data: userModel);
    }
  }

  @override
  Future<Result<Map<String, dynamic>>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    Result result = await authServices.signInWithEmailAndPassword(
      email,
      password,
    );
    if (result.error != null) {
      return Result.failure(error: result.error);
    } else {
      final responceData = result.data as dio.Response;

      return Result.success(data: responceData.data);
    }
  }
}
