import 'package:bigsizeship_mobile/core/usecase/usecase.dart';
import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/address/data/models/district_model.dart';
import 'package:bigsizeship_mobile/src/address/domain/repositories/address_repository.dart';
import 'package:equatable/equatable.dart';

class GetListDistricts
    extends UsecaseWithParams<List<DistrictModel>, GetListDistrictsParams> {
  const GetListDistricts(this._repository);

  final AddressRepository _repository;
  @override
  ResultFuture<List<DistrictModel>> call(GetListDistrictsParams params) async =>
      _repository.getListDistricts(provinceId: params.provinceId);
}

class GetListDistrictsParams extends Equatable {
  const GetListDistrictsParams({
    required this.provinceId,
  });

  final String provinceId;
  @override
  List<Object?> get props => [];
}
