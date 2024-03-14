import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/authentication/data/models/user_model.dart';

abstract class AuthenticationReposiroty {
  const AuthenticationReposiroty();

  ResultFuture<UserModel> login({
    required String email,
    required String password,
  });

  ResultFuture<UserModel> getMe({
    required String token,
  });
}
