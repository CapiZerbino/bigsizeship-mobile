import 'package:bigsizeship_mobile/src/address/domain/entities/address.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/district.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/province.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/ward.dart';
import 'package:bigsizeship_mobile/src/address/domain/usecases/create_address.dart';
import 'package:bigsizeship_mobile/src/address/domain/usecases/get_address.dart';
import 'package:bigsizeship_mobile/src/address/domain/usecases/get_districts.dart';
import 'package:bigsizeship_mobile/src/address/domain/usecases/get_provinces.dart';
import 'package:bigsizeship_mobile/src/address/domain/usecases/get_wards.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc({
    required GetListAddresses getListAddresses,
    required GetListProvinces getListProvinces,
    required GetListDistricts getListDistricts,
    required GetListWards getListWards,
    required CreateAddress createAddress,
  })  : _getListAddresses = getListAddresses,
        _getListProvinces = getListProvinces,
        _getListDistricts = getListDistricts,
        _getListWards = getListWards,
        _createAddress = createAddress,
        super(const AddressInitial()) {
    on<AddressEvent>((event, emit) {
      emit(const GetListAddressesLoading());
    });
    on<GetListAddressesEvent>(_getListAddressesHandler);
    on<GetListProvincesEvent>(_getListProvincesHandler);
    on<GetListDistrictsEvent>(_getListDistrictsHandler);
    on<GetListWardsEvent>(_getListWardsHandler);
    on<CreateAddressEvent>(_createAddressHandler);
  }

  final GetListAddresses _getListAddresses;
  final GetListProvinces _getListProvinces;
  final GetListDistricts _getListDistricts;
  final GetListWards _getListWards;
  final CreateAddress _createAddress;

  List<Address>? _addresses;
  List<Address>? get addresses => _addresses;

  Future<void> _getListAddressesHandler(
    GetListAddressesEvent event,
    Emitter<AddressState> emit,
  ) async {
    final result = await _getListAddresses(
      GetListAddressesParams(
        userId: event.userId,
        addressType: event.addressType,
      ),
    );

    _addresses = result.getOrElse(() => []);

    result.fold(
      (failure) => emit(GetListAddressesError(failure.errorMessage)),
      (addresses) => emit(GetListAddressesSuccess(addresses)),
    );
  }

  Future<void> _getListProvincesHandler(
    GetListProvincesEvent event,
    Emitter<AddressState> emit,
  ) async {
    final result = await _getListProvinces(
      const GetListProvincesParams(),
    );

    result.fold(
      (failure) => emit(GetListAddressesError(failure.errorMessage)),
      (addresses) => emit(GetListProvincesSuccess(addresses)),
    );
  }

  Future<void> _getListDistrictsHandler(
    GetListDistrictsEvent event,
    Emitter<AddressState> emit,
  ) async {
    final result = await _getListDistricts(
      GetListDistrictsParams(provinceId: event.provinceId),
    );

    result.fold(
      (failure) => emit(GetListAddressesError(failure.errorMessage)),
      (addresses) => emit(GetListDistrictsSuccess(addresses)),
    );
  }

  Future<void> _getListWardsHandler(
    GetListWardsEvent event,
    Emitter<AddressState> emit,
  ) async {
    final result = await _getListWards(
      GetListWardsParams(districtId: event.districtId),
    );

    result.fold(
      (failure) => emit(GetListAddressesError(failure.errorMessage)),
      (addresses) => emit(GetListWardsSuccess(addresses)),
    );
  }

  Future<void> _createAddressHandler(
    CreateAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(const CreateAddressLoading());
    final result = await _createAddress(
      CreateAddressParams(
        userId: event.userId,
        addressType: AddressType.SENDER,
        address: event.address,
        province: event.province,
        district: event.district,
        ward: event.ward,
        name: event.name,
        phoneNumber: event.phoneNumber,
        isDefault: false,
        provinceCode: event.provinceCode,
        districtCode: event.districtCode,
        wardCode: event.wardCode,
      ),
    );

    emit(const ReloadListAddress());

    result.fold(
      (failure) => emit(CreateAddressError(failure.errorMessage)),
      (address) => emit(CreateAddressSuccess(address)),
    );
  }
}
