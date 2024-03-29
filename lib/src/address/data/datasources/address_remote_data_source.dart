import 'package:bigsizeship_mobile/core/services/api_request.dart';
import 'package:bigsizeship_mobile/core/utils/constants.dart';
import 'package:bigsizeship_mobile/core/utils/pagination.dart';
import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/address/data/models/address_model.dart';
import 'package:bigsizeship_mobile/src/address/data/models/district_model.dart';
import 'package:bigsizeship_mobile/src/address/data/models/province_model.dart';
import 'package:bigsizeship_mobile/src/address/data/models/ward_model.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/address.dart';

abstract class AddressRemoteDataSource {
  const AddressRemoteDataSource();

  Future<List<AddressModel>> getListAddresses({
    required int userId,
    required AddressType addressType,
  });

  Future<AddressModel> createAddress({
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
  });

  Future<AddressModel> deleteAddress({required int id});
  Future<List<ProvinceModel>> getListProvinces();
  Future<List<DistrictModel>> getListDistricts({
    required String provinceId,
  });
  Future<List<WardModel>> getListWards({
    required String districtId,
  });
}

class AddressRemoteDataSourceImplementation implements AddressRemoteDataSource {
  const AddressRemoteDataSourceImplementation();
  @override
  Future<AddressModel> createAddress({
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
      final result = await ApiRequest().create<DataMap>(
        resource: 'v1/addresses',
        payload: {
          'address': address,
          'province': province,
          'province_code': provinceCode,
          'district': district,
          'district_code': districtCode,
          'ward': ward,
          'ward_code': wardCode,
          'name': name,
          'phone_number': phoneNumber,
          'is_default': isDefault,
          'address_type': addressType.name,
          'user': userId,
        },
      );

      return AddressModel.fromMap(result['data'] as DataMap);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<AddressModel> deleteAddress({required int id}) {
    // TODO: implement deleteAddress
    throw UnimplementedError();
  }

  @override
  Future<List<AddressModel>> getListAddresses({
    required int userId,
    required AddressType addressType,
  }) async {
    try {
      final result = await ApiRequest().custom<List<DataMap>>(
        url: '$kBaseUrl/v1/addresses',
        method: 'GET',
        filters: [],
        sorters: [],
        headers: {},
        query: {'address_type': addressType.name, 'user_id': userId},
      );
      return result.data.map(AddressModel.fromMap).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<DistrictModel>> getListDistricts({
    required String provinceId,
  }) async {
    try {
      final result = await ApiRequest().custom<List<DataMap>>(
        url: '$kBaseUrl/v1/districts',
        method: 'GET',
        filters: [
          CrudFilter(
            field: 'province.province_id',
            operator: CrudOperators.eq,
            value: provinceId,
          ),
        ],
        sorters: [],
        headers: {},
        query: {},
      );

      return result.data.map(DistrictModel.fromMap).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ProvinceModel>> getListProvinces() async {
    try {
      final result = await ApiRequest().custom<List<DataMap>>(
        url: '$kBaseUrl/v1/provinces',
        method: 'GET',
        filters: [],
        sorters: [],
        headers: {},
        query: {},
      );

      return result.data.map(ProvinceModel.fromMap).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<WardModel>> getListWards({required String districtId}) async {
    try {
      final result = await ApiRequest().custom<List<DataMap>>(
        url: '$kBaseUrl/v1/wards',
        method: 'GET',
        filters: [
          CrudFilter(
            field: 'district.district_id',
            operator: CrudOperators.eq,
            value: districtId,
          ),
        ],
        sorters: [],
        headers: {},
        query: {},
      );

      return result.data.map(WardModel.fromMap).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
