import 'dart:math';

import 'package:bigsizeship_mobile/src/address/domain/entities/address.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/district.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/province.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/ward.dart';
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
  })  : _getListAddresses = getListAddresses,
        _getListProvinces = getListProvinces,
        _getListDistricts = getListDistricts,
        _getListWards = getListWards,
        super(const AddressInitial()) {
    on<AddressEvent>((event, emit) {
      emit(const GetListAddressesLoading());
    });
    on<GetListAddressesEvent>(_getListAddressesHandler);
    on<GetListProvincesEvent>(_getListProvincesHandler);
    on<GetListDistrictsEvent>(_getListDistrictsHandler);
    on<GetListWardsEvent>(_getListWardsHandler);
  }

  final GetListAddresses _getListAddresses;
  final GetListProvinces _getListProvinces;
  final GetListDistricts _getListDistricts;
  final GetListWards _getListWards;

  final List<Address> _addresses = [];
  final List<Province> _provinces = [];
  final List<District> _districts = [];
  final List<Ward> _wards = [];

  Future<void> _getListAddressesHandler(
    GetListAddressesEvent event,
    Emitter<AddressState> emit,
  ) async {
    final result = await _getListAddresses(
      const GetListAddressesParams(
        userId: 1,
        addressType: AddressType.SENDER,
      ),
    );

    // _addresses.addAll(result.getOrElse(() => []));
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

    // _provinces.addAll(result.getOrElse(() => []));
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

    // _districts.addAll(result.getOrElse(() => []));
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

    // _wards.addAll(result.getOrElse(() => []));
    result.fold(
      (failure) => emit(GetListAddressesError(failure.errorMessage)),
      (addresses) => emit(GetListWardsSuccess(addresses)),
    );
  }
}
