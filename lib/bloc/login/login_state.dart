

part of 'login_cubit.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSucceed extends LoginState {}

class LoginError extends LoginState {
  final String error;
  LoginError(this.error);
}

class RememberMeChanged extends LoginState {}