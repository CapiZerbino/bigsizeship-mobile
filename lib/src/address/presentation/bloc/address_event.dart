part of 'address_bloc.dart';

sealed class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class GetListAddressesEvent extends AddressEvent {
  const GetListAddressesEvent();
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
