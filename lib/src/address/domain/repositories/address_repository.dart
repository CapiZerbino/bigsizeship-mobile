import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/address/data/models/address_model.dart';
import 'package:bigsizeship_mobile/src/address/data/models/district_model.dart';
import 'package:bigsizeship_mobile/src/address/data/models/province_model.dart';
import 'package:bigsizeship_mobile/src/address/data/models/ward_model.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/address.dart';

abstract class AddressRepository {
  const AddressRepository();

  ResultFuture<List<AddressModel>> getListAddresses({
    required int userId,
    required AddressType addressType,
  });
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
  });
  ResultFuture<AddressModel> deleteAddress({required int id});

  ResultFuture<List<ProvinceModel>> getListProvinces();
  ResultFuture<List<DistrictModel>> getListDistricts({
    required String provinceId,
  });
  ResultFuture<List<WardModel>> getListWards({
    required String districtId,
  });
}
