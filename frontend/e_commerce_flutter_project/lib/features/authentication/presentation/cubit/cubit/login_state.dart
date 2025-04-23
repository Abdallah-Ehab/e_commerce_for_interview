part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState{}

final class LoginSuccess extends LoginState{
  final String successData;
  LoginSuccess({required this.successData});
}

final class LoginFailure extends LoginState{
  final String error;
  LoginFailure({required this.error});
}
