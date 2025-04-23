import 'package:bloc/bloc.dart';
import 'package:e_commerce_flutter_project/features/authentication/domain/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'ensure_logged_in_state.dart';

class EnsureLoggedInCubit extends Cubit<EnsureLoggedInState> {
  AuthRepo authRepo;
  EnsureLoggedInCubit({required this.authRepo}) : super(EnsureLoggedInInitial());

  void checkLoginStatus() async{
    emit(EnsureLoggedInLoading());
    try {
      final res = await authRepo.ensureLoggedIn();
      final isLoggedin = res.successData;
      if (isLoggedin != null) {
        emit(EnsureLoggedInSuccess(isLoggedIn: isLoggedin));
      } else {
        emit(EnsureLoggedInError(error: "Failed to check login status"));
      }
    } catch (e) {
      emit(EnsureLoggedInError(error: e.toString()));
    }
  }
  void logOut()async{
    await authRepo.logOut();
    final bool isLoggedin = false;
    emit(EnsureLoggedInSuccess(isLoggedIn: isLoggedin));
  }
}
