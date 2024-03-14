import 'dart:convert';

import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/order/domain/entities/carrier.dart';

class CarrierModel extends Carrier {
  const CarrierModel({
    required super.id,
    required super.name,
  });

  factory CarrierModel.fromJson(String source) {
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
    return CarrierModel.fromMap(normalized);
  }

  CarrierModel.fromMap(DataMap map)
      : this(
          id: map['id'] as int,
          name: map['name'] as String,
        );

  CarrierModel copyWith({
    int? id,
    String? name,
  }) {
    return CarrierModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  DataMap toMap() => {
        'id': id,
        'name': name,
      };

  String toJson() => jsonEncode(toMap());
}
