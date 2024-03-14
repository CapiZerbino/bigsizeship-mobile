import 'package:bigsizeship_mobile/core/usecase/usecase.dart';
import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/address/data/models/address_model.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/address.dart';
import 'package:bigsizeship_mobile/src/address/domain/repositories/address_repository.dart';
import 'package:equatable/equatable.dart';

class GetListAddresses
    extends UsecaseWithParams<List<AddressModel>, GetListAddressesParams> {
  const GetListAddresses(this._repository);

  final AddressRepository _repository;
  @override
  ResultFuture<List<AddressModel>> call(GetListAddressesParams params) async =>
      _repository.getListAddresses(
        userId: params.userId,
        addressType: params.addressType,
      );
}

class GetListAddressesParams extends Equatable {
  const GetListAddressesParams({
    required this.userId,
    required this.addressType,
  });

  final int userId;
  final AddressType addressType;

  @override
  List<Object?> get props => [];
}
