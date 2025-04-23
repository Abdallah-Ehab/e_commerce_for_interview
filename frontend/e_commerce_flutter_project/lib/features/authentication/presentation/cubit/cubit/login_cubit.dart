import 'package:bloc/bloc.dart';
import 'package:e_commerce_flutter_project/features/authentication/domain/usecases/login_use_case.dart';
import 'package:flutter/widgets.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  Future<void> login(String? email,String? password) async {
    emit(LoginLoading());
    try {
      if(email == null || password == null) {
        emit(LoginFailure(error:"Please fill all fields"));
        return;
      }
      final result = await loginUseCase.call(LoginParams(email: email, password: password));
      if (result.error != null) {
        emit(LoginFailure(error:result.error!.message));
      } else {
        emit(LoginSuccess(successData:"registered successfully"));
      }
    } catch (e) {
      emit(LoginFailure(error:e.toString()));
    }
  }
  
}
