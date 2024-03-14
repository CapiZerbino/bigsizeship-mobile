import 'package:bigsizeship_mobile/core/usecase/usecase.dart';
import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/address/data/models/address_model.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/address.dart';
import 'package:bigsizeship_mobile/src/address/domain/repositories/address_repository.dart';
import 'package:equatable/equatable.dart';

class CreateAddress
    extends UsecaseWithParams<AddressModel, CreateAddressParams> {
  const CreateAddress(this._repository);
  final AddressRepository _repository;

  @override
  ResultFuture<AddressModel> call(CreateAddressParams params) async =>
      _repository.createAddress(
        address: params.address,
        province: params.province,
        provinceCode: params.provinceCode,
        district: params.district,
        districtCode: params.districtCode,
        ward: params.ward,
        wardCode: params.wardCode,
        name: params.name,
        phoneNumber: params.phoneNumber,
        isDefault: params.isDefault,
        addressType: params.addressType,
      );
}

class CreateAddressParams extends Equatable {
  const CreateAddressParams({
    required this.address,
    required this.province,
    required this.provinceCode,
    required this.district,
    required this.districtCode,
    required this.ward,
    required this.wardCode,
    required this.name,
    required this.phoneNumber,
    required this.isDefault,
    required this.addressType,
  });

  final String address;
  final String province;
  final String provinceCode;
  final String district;
  final String districtCode;
  final String ward;
  final String wardCode;
  final String name;
  final String phoneNumber;
  final bool isDefault;
  final AddressType addressType;

  @override
  List<Object?> get props => [];
}
