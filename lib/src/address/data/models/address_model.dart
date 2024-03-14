import 'dart:convert';

import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required super.id,
    required super.address,
    required super.province,
    required super.provinceCode,
    required super.district,
    required super.districtCode,
    required super.ward,
    required super.wardCode,
    required super.name,
    required super.phoneNumber,
    required super.isDefault,
    required super.addressType,
  });

  factory AddressModel.fromJson(String source) {
    final jsonData = jsonDecode(source) as DataMap;
    DataMap normalized = {};
    if (jsonData['data'] != null) {
      normalized = {
        'id': jsonData['data']['id'],
        ...jsonData['data']['attributes'] as DataMap,
      };
    } else {
      normalized = jsonData;
    }
    return AddressModel.fromMap(jsonDecode(source) as DataMap);
  }

  AddressModel.fromMap(DataMap map)
      : this(
          id: map['id'] as int,
          address: map['address'] as String,
          province: map['province'] as String,
          provinceCode: map['province_code'] as String,
          district: map['district'] as String,
          districtCode: map['district_code'] as String,
          ward: map['ward'] as String,
          wardCode: map['ward_code'] as String,
          name: map['name'] as String,
          phoneNumber: map['phone_number'] as String,
          isDefault: map['default'] as bool,
          addressType: map['address_type'] == AddressType.RECEIVER.name
              ? AddressType.RECEIVER
              : AddressType.SENDER,
        );

  AddressModel copyWith({
    int? id,
    String? address,
    String? province,
    String? provinceCode,
    String? district,
    String? districtCode,
    String? ward,
    String? wardCode,
    String? name,
    String? phoneNumber,
    bool? isDefault,
    AddressType? addressType,
  }) {
    return AddressModel(
      id: id ?? this.id,
      address: address ?? this.address,
      province: province ?? this.province,
      provinceCode: provinceCode ?? this.provinceCode,
      district: district ?? this.district,
      districtCode: districtCode ?? this.districtCode,
      ward: ward ?? this.ward,
      wardCode: wardCode ?? this.wardCode,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isDefault: isDefault ?? this.isDefault,
      addressType: addressType ?? this.addressType,
    );
  }

  DataMap toMap() => {
        'id': id,
        'name': name,
      };

  String toJson() => jsonEncode(toMap());
}
