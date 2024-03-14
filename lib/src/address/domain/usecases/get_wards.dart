import 'package:bigsizeship_mobile/core/usecase/usecase.dart';
import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/address/data/models/ward_model.dart';
import 'package:bigsizeship_mobile/src/address/domain/repositories/address_repository.dart';
import 'package:equatable/equatable.dart';

class GetListWards
    extends UsecaseWithParams<List<WardModel>, GetListWardsParams> {
  const GetListWards(this._repository);

  final AddressRepository _repository;
  @override
  ResultFuture<List<WardModel>> call(GetListWardsParams params) async =>
      _repository.getListWards(districtId: params.districtId);
}

class GetListWardsParams extends Equatable {
  const GetListWardsParams({
    required this.districtId,
  });

  final String districtId;
  @override
  List<Object?> get props => [];
}
