import 'package:bigsizeship_mobile/src/authentication/domain/entities/role.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.confirmed,
    required this.blocked,
    required this.provider,
    this.username,
    this.phoneNumber,
    this.email,
    this.updatedAt,
    this.createdAt,
    this.role,
    this.sale,
  });

  final int id;
  final String? username;
  final String? phoneNumber;
  final String? email;
  final String? updatedAt;
  final String? createdAt;
  final bool confirmed;
  final bool blocked;
  final String provider;
  final Role? role;
  final User? sale;

  @override
  List<Object?> get props => [id];
}
