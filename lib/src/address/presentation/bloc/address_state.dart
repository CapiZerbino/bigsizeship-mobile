part of 'address_bloc.dart';

sealed class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

final class AddressInitial extends AddressState {
  const AddressInitial();
}

class GetListAddressesLoading extends AddressState {
  const GetListAddressesLoading();
}

class GetListAddressesSuccess extends AddressState {
  const GetListAddressesSuccess(this.addresses);
  final List<Address> addresses;

  @override
  List<Object> get props => [addresses];
}

class ReloadListAddress extends AddressState {
  const ReloadListAddress();
}

class GetListProvincesSuccess extends AddressState {
  const GetListProvincesSuccess(this.provinces);
  final List<Province> provinces;

  @override
  List<Object> get props => [provinces];
}

class GetListDistrictsSuccess extends AddressState {
  const GetListDistrictsSuccess(this.districts);
  final List<District> districts;

  @override
  List<Object> get props => [districts];
}

class GetListWardsSuccess extends AddressState {
  const GetListWardsSuccess(this.wards);
  final List<Ward> wards;

  @override
  List<Object> get props => [wards];
}

class GetListAddressesError extends AddressState {
  const GetListAddressesError(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}

class CreateAddressLoading extends AddressState {
  const CreateAddressLoading();
}

class CreateAddressSuccess extends AddressState {
  const CreateAddressSuccess(this.address);
  final Address address;

  @override
  List<Object> get props => [address];
}

class CreateAddressError extends AddressState {
  const CreateAddressError(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
