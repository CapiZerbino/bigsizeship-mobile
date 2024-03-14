import 'package:bigsizeship_mobile/core/usecase/usecase.dart';
import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/authentication/data/models/user_model.dart';
import 'package:bigsizeship_mobile/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class Login extends UsecaseWithParams<UserModel, LoginParams> {
  const Login(this._repository);
  final AuthenticationReposiroty _repository;

  @override
  ResultFuture<UserModel> call(LoginParams params) async => _repository.login(
        email: params.email,
        password: params.password,
      );
}

class LoginParams extends Equatable {
  const LoginParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
