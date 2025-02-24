
import 'package:firebase_auth/firebase_auth.dart';
class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}

abstract class RegisterState {}
class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterSuccess extends RegisterState {}
class RegisterFailure extends RegisterState {
  final String error;
  RegisterFailure(this.error);
}

abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutSuccess extends LogoutState {}

class LogoutFailure extends LogoutState {
  final String errorMessage;
  LogoutFailure(this.errorMessage);
}
