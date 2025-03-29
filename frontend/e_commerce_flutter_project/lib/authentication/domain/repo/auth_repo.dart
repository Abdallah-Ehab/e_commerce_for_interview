import 'package:e_commerce_flutter_project/authentication/data/models/user_model.dart';
import 'package:e_commerce_flutter_project/authentication/data/services/auth_services.dart';

abstract class AuthRepo {
  Future<Result<UserModel>> signInWithEmailAndPassword(String email, String password);
  Future<Result<UserModel>> signUpWithEmailAndPassword(String email, String password);
}