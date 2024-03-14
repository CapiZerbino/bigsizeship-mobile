import 'package:bigsizeship_mobile/core/usecase/usecase.dart';
import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/authentication/data/models/user_model.dart';
import 'package:bigsizeship_mobile/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class GetMe extends UsecaseWithParams<UserModel, GetMeParams> {
  const GetMe(this._repository);
  final AuthenticationReposiroty _repository;

  @override
  ResultFuture<UserModel> call(GetMeParams params) async =>
      _repository.getMe(token: params.token);
}

class GetMeParams extends Equatable {
  const GetMeParams({
    required this.token,
  });

  final String token;

  @override
  List<Object?> get props => [token];
}
