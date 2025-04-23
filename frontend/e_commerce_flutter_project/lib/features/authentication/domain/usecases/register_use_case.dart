import 'package:e_commerce_flutter_project/core/utils/result.dart';
import 'package:e_commerce_flutter_project/core/utils/use_case.dart';
import 'package:e_commerce_flutter_project/features/authentication/domain/repo/auth_repo.dart';

class RegisterUseCase implements UseCase<String, RegisterParams> {
  final AuthRepo authRepo;

  RegisterUseCase({required this.authRepo});

  @override
  Future<Result<String>> call(RegisterParams params) async {
    return await authRepo.registerWithNameEmailAndPassword(params.name,params.email, params.password);
  }
}

class RegisterParams{
  final String name;
  final String email;
  final String password;

  RegisterParams({required this.name,required this.email, required this.password});
}