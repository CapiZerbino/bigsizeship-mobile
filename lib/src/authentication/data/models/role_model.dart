import 'dart:convert';

import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/authentication/domain/entities/role.dart';

class RoleModel extends Role {
  const RoleModel({
    required super.id,
    required super.name,
    required super.description,
    required super.type,
    required super.updatedAt,
    required super.createdAt,
  });

  factory RoleModel.fromJson(String source) =>
      RoleModel.fromMap(jsonDecode(source) as DataMap);

  RoleModel.fromMap(DataMap map)
      : this(
          id: map['id'] as int,
          name: map['name'] as String,
          description: map['description'] as String,
          type: map['type'] as String,
          updatedAt: map['updatedAt'] as String,
          createdAt: map['createdAt'] as String,
        );

  RoleModel copyWith({
    String? name,
    String? description,
    String? type,
    String? updatedAt,
    String? createdAt,
  }) {
    return RoleModel(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  DataMap toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'email': type,
        'updatedAt': updatedAt,
        'createdAt': createdAt,
      };

  String toJson() => jsonEncode(toMap());
}
