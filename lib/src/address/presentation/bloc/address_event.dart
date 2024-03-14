part of 'address_bloc.dart';

sealed class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class GetListAddressesEvent extends AddressEvent {
  const GetListAddressesEvent({
    required this.addressType,
    required this.userId,
  });

  final AddressType addressType;
  final int userId;

  @override
  List<Object> get props => [addressType, userId];
}

class GetListProvincesEvent extends AddressEvent {
  const GetListProvincesEvent();
}

class GetListDistrictsEvent extends AddressEvent {
  const GetListDistrictsEvent({
    required this.provinceId,
  });

  final String provinceId;

  @override
  List<Object> get props => [provinceId];
}

class GetListWardsEvent extends AddressEvent {
  const GetListWardsEvent({
    required this.districtId,
  });

  final String districtId;

  @override
  List<Object> get props => [districtId];
}

class CreateAddressEvent extends AddressEvent {
  const CreateAddressEvent({
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
    required this.userId,
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
  final int userId;

  @override
  List<Object> get props => [
        address,
        province,
        provinceCode,
        district,
        districtCode,
        ward,
        wardCode,
        name,
        phoneNumber,
        isDefault,
        addressType,
        userId,
      ];
}
