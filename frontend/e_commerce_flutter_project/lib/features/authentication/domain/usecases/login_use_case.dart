import 'package:e_commerce_flutter_project/core/utils/result.dart';
import 'package:e_commerce_flutter_project/core/utils/use_case.dart';
import 'package:e_commerce_flutter_project/features/authentication/domain/repo/auth_repo.dart';

class LoginUseCase implements UseCase<String, LoginParams> {
  final AuthRepo authRepo;
  LoginUseCase({required this.authRepo});
  @override
  Future<Result<String>> call(LoginParams params) async {
    Result<String> res = await authRepo.loginWithEmailAndPassword(params.email, params.password);
    return res;
  }
}




class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}