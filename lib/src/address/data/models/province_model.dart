import 'dart:convert';

import 'package:bigsizeship_mobile/core/utils/typedef.dart';

import 'package:bigsizeship_mobile/src/address/domain/entities/province.dart';

class ProvinceModel extends Province {
  const ProvinceModel({
    required super.id,
    required super.provinceId,
    required super.name,
  });

  factory ProvinceModel.fromJson(String source) {
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
    return ProvinceModel.fromMap(jsonDecode(source) as DataMap);
  }

  ProvinceModel.fromMap(DataMap map)
      : this(
          id: map['id'] as int,
          provinceId: map['province_id'] as String,
          name: map['name'] as String,
        );

  ProvinceModel copyWith({
    int? id,
    String? name,
    String? provinceId,
  }) {
    return ProvinceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      provinceId: provinceId ?? this.provinceId,
    );
  }

  DataMap toMap() => {
        'id': id,
        'name': name,
      };

  String toJson() => jsonEncode(toMap());
}
