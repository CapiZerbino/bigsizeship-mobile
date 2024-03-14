import 'dart:convert';

import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/address/data/models/province_model.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/district.dart';

class DistrictModel extends District {
  DistrictModel({
    required super.id,
    required super.districtId,
    required super.name,
    super.province,
  });

  factory DistrictModel.fromJson(String source) {
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
    return DistrictModel.fromMap(jsonDecode(source) as DataMap);
  }

  DistrictModel.fromMap(DataMap map)
      : this(
          id: map['id'] as int,
          districtId: map['district_id'] as String,
          name: map['name'] as String,
          province: map['province'] != null
              ? ProvinceModel.fromMap(map['province'] as DataMap)
              : null,
        );

  DistrictModel copyWith({
    int? id,
    String? districtId,
    String? name,
    ProvinceModel? province,
  }) {
    return DistrictModel(
      id: id ?? this.id,
      districtId: districtId ?? this.districtId,
      name: name ?? this.name,
      province: province ?? this.province,
    );
  }

  DataMap toMap() => {
        'id': id,
        'name': name,
      };

  String toJson() => jsonEncode(toMap());
}
