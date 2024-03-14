import 'dart:convert';

import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/address/data/models/district_model.dart';
import 'package:bigsizeship_mobile/src/address/domain/entities/ward.dart';

class WardModel extends Ward {
  WardModel({
    required super.id,
    required super.wardId,
    required super.name,
    super.district,
  });

  factory WardModel.fromJson(String source) {
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
    return WardModel.fromMap(jsonDecode(source) as DataMap);
  }

  WardModel.fromMap(DataMap map)
      : this(
          id: map['id'] as int,
          wardId: map['ward_id'] as String,
          name: map['name'] as String,
          district: map['district'] != null
              ? DistrictModel.fromMap(map['district'] as DataMap)
              : null,
        );

  WardModel copyWith({
    int? id,
    String? wardId,
    String? name,
    DistrictModel? district,
  }) {
    return WardModel(
      id: id ?? this.id,
      wardId: wardId ?? this.wardId,
      name: name ?? this.name,
      district: district ?? this.district,
    );
  }

  DataMap toMap() => {
        'id': id,
        'name': name,
      };

  String toJson() => jsonEncode(toMap());
}
