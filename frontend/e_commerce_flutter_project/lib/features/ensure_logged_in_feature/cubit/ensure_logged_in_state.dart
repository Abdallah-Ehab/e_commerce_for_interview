part of 'ensure_logged_in_cubit.dart';

@immutable
sealed class EnsureLoggedInState {}

final class EnsureLoggedInInitial extends EnsureLoggedInState {}

final class EnsureLoggedInLoading extends EnsureLoggedInState {}
final class EnsureLoggedInSuccess extends EnsureLoggedInState {
  final bool isLoggedIn;

  EnsureLoggedInSuccess({required this.isLoggedIn});
}
final class EnsureLoggedInError extends EnsureLoggedInState {
  final String error;

  EnsureLoggedInError({required this.error});
}