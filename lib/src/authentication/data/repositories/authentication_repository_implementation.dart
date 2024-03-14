import 'package:bigsizeship_mobile/core/errors/exception.dart';
import 'package:bigsizeship_mobile/core/errors/failure.dart';
import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:bigsizeship_mobile/src/authentication/data/models/user_model.dart';
import 'package:bigsizeship_mobile/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImplementation extends AuthenticationReposiroty {
  const AuthenticationRepositoryImplementation(this._remoteDataSource);
  final AuthenticationRemoteDataSource _remoteDataSource;
  @override
  ResultFuture<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final user =
          await _remoteDataSource.login(email: email, password: password);
      return Right(user);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<UserModel> getMe({required String token}) async {
    try {
      final user = await _remoteDataSource.getMe(token: token);
      return Right(user);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
