import 'package:bloc/bloc.dart';
import 'package:e_commerce_flutter_project/features/authentication/domain/usecases/register_use_case.dart';


part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {

  final RegisterUseCase registerUseCase;

  RegisterCubit({required this.registerUseCase}) : super(RegisterInitial());

 
  Future<void> register(String? name, String? email,String? password) async {
    emit(RegisterLoading());
    try {
      if(name == null || email == null || password == null) {
        emit(RegisterFailure("Please fill all fields"));
        return;
      }
      final result = await registerUseCase.call(RegisterParams(name: name, email: email, password: password));
      if (result.error != null) {
        emit(RegisterFailure(result.error!.message));
      } else {
        emit(RegisterSuccess("registered successfully"));
      }
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
