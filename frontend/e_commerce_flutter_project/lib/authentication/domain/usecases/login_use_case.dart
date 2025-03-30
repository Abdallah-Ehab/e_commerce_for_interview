import 'package:e_commerce_flutter_project/authentication/data/models/user_model.dart';
import 'package:e_commerce_flutter_project/authentication/data/services/auth_services.dart';
import 'package:e_commerce_flutter_project/authentication/domain/repo/auth_repo.dart';
import 'package:e_commerce_flutter_project/authentication/domain/usecases/register_use_case.dart';
import 'package:e_commerce_flutter_project/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginUseCase implements UseCase<UserModel, LoginParams> {
  final AuthRepo authRepo;
  LoginUseCase({required this.authRepo});
  @override
  Future<Result<UserModel>> call(LoginParams params) async {
    Result res = await authRepo.signInWithEmailAndPassword(params.email, params.password);
    if(res.error != null){
      return Result.failure(error: res.error);
    }else{
      final responceData = res.data as Map<String,dynamic>;
      String token = responceData['token'];
      storeToke('token', token);
      UserModel userModel = UserModel.fromJson(responceData['user']);
      return Result.success(data: userModel);
    }
  }
}

void storeToke(String key,String value){
  FlutterSecureStorage storage = Storage.instance;
  storage.write(key: key, value: value);
}



class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}