import 'package:e_commerce_flutter_project/authentication/data/models/user_model.dart';
import 'package:e_commerce_flutter_project/authentication/data/services/auth_services.dart';
import 'package:e_commerce_flutter_project/authentication/domain/repo/auth_repo.dart';

class RegisterUseCase implements UseCase<UserModel, RegisterParams> {
  final AuthRepo authRepo;

  RegisterUseCase({required this.authRepo});

  @override
  Future<Result<UserModel>> call(RegisterParams params) async {
    return await authRepo.signUpWithNameEmailAndPassword(params.name,params.email, params.password);
  }
}

abstract class UseCase<T,Params>{
  Future<Result<T>> call(Params params);
}

class RegisterParams{
  final String name;
  final String email;
  final String password;

  RegisterParams({required this.name,required this.email, required this.password});
}