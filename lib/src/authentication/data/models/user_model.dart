import 'dart:convert';

import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/authentication/data/models/role_model.dart';
import 'package:bigsizeship_mobile/src/authentication/domain/entities/role.dart';
import 'package:bigsizeship_mobile/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.confirmed,
    required super.blocked,
    required super.provider,
    super.username,
    super.phoneNumber,
    super.email,
    super.updatedAt,
    super.createdAt,
    super.role,
    super.sale,
  });

  factory UserModel.fromJson(String source) {
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
    return UserModel.fromMap(normalized);
  }

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'] as int,
          username: map['username'] as String,
          phoneNumber: map['phone_number'] as String?,
          email: map['email'] as String,
          updatedAt: map['updatedAt'] as String,
          createdAt: map['createdAt'] as String,
          confirmed: map['confirmed'] as bool,
          blocked: map['blocked'] as bool,
          provider: map['provider'] as String,
          role: map['role'] != null
              ? RoleModel.fromMap(map['role'] as DataMap)
              : null,
          sale: map['sale'] != null
              ? UserModel.fromMap(map['sale'] as DataMap)
              : null,
        );

  UserModel copyWith({
    String? username,
    String? phoneNumber,
    String? email,
    String? updatedAt,
    String? createdAt,
    bool? confirmed,
    bool? blocked,
    String? provider,
    Role? role,
    User? sale,
  }) {
    return UserModel(
      id: id,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      confirmed: confirmed ?? this.confirmed,
      blocked: blocked ?? this.blocked,
      provider: provider ?? this.provider,
      role: role ?? this.role,
      sale: sale ?? this.sale,
    );
  }

  DataMap toMap() => {
        'id': id,
        'username': username,
        'phone_number': phoneNumber,
        'email': email,
        'updatedAt': updatedAt,
        'createdAt': createdAt,
        'confirmed': confirmed,
        'blocked': blocked,
        'provider': provider,
        'role': role,
        'sale': sale,
      };

  String toJson() => jsonEncode(toMap());
}
