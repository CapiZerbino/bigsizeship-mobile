import 'package:bigsizeship_mobile/core/usecase/usecase.dart';
import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/address/data/models/province_model.dart';
import 'package:bigsizeship_mobile/src/address/domain/repositories/address_repository.dart';
import 'package:equatable/equatable.dart';

class GetListProvinces
    extends UsecaseWithParams<List<ProvinceModel>, GetListProvincesParams> {
  const GetListProvinces(this._repository);

  final AddressRepository _repository;
  @override
  ResultFuture<List<ProvinceModel>> call(GetListProvincesParams params) async =>
      _repository.getListProvinces();
}

class GetListProvincesParams extends Equatable {
  const GetListProvincesParams();

  @override
  List<Object?> get props => [];
}
