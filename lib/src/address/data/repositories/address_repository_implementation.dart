import 'package:bigsizeship_mobile/core/errors/exception.dart';
import 'package:bigsizeship_mobile/core/errors/failure.dart';
import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/address/data/datasources/address_remote_data_source.dart';
import 'package:bigsizeship_mobile/src/address/data/models/address_model.dart';
import 'package:bigsizeship_mobile/src/address/data/models/district_model.dart';
import 'package:bigsizeship_mobile/src/address/data/models/province_model.dart';
import 'package:bigsizeship_mobile/src/address/data/models/ward_model.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/address.dart';
import 'package:bigsizeship_mobile/src/address/domain/repositories/address_repository.dart';
import 'package:dartz/dartz.dart';

class AddressRepositoryImplementation implements AddressRepository {
  const AddressRepositoryImplementation(this._remoteDataSource);

  final AddressRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<AddressModel> createAddress({
    required String address,
    required String province,
    required String provinceCode,
    required String district,
    required String districtCode,
    required String ward,
    required String wardCode,
    required String name,
    required String phoneNumber,
    required bool isDefault,
    required AddressType addressType,
    required int userId,
  }) async {
    try {
      final result = await _remoteDataSource.createAddress(
        address: address,
        province: province,
        provinceCode: provinceCode,
        district: district,
        districtCode: districtCode,
        ward: ward,
        wardCode: wardCode,
        name: name,
        phoneNumber: phoneNumber,
        isDefault: isDefault,
        addressType: addressType,
        userId: userId,
      );
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<AddressModel> deleteAddress({required int id}) async {
    try {
      final result = await _remoteDataSource.deleteAddress(id: id);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<AddressModel>> getListAddresses({
    required int userId,
    required AddressType addressType,
  }) async {
    try {
      final result = await _remoteDataSource.getListAddresses(
        userId: userId,
        addressType: addressType,
      );
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<DistrictModel>> getListDistricts(
      {required String provinceId}) async {
    try {
      final result =
          await _remoteDataSource.getListDistricts(provinceId: provinceId);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProvinceModel>> getListProvinces() async {
    try {
      final result = await _remoteDataSource.getListProvinces();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<WardModel>> getListWards({
    required String districtId,
  }) async {
    try {
      final result =
          await _remoteDataSource.getListWards(districtId: districtId);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
