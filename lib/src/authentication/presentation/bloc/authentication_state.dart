part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class LoginLoading extends AuthenticationState {
  const LoginLoading();
}

class Logined extends AuthenticationState {
  const Logined(this.user);
  final User user;

  @override
  List<Object> get props => [user];
}

class AuthenticationError extends AuthenticationState {
  const AuthenticationError(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
