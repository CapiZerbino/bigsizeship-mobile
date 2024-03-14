import 'package:equatable/equatable.dart';

class Role extends Equatable {
  const Role({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.updatedAt,
    required this.createdAt,
  });

  final int id;
  final String name;
  final String description;
  final String type;
  final String updatedAt;
  final String createdAt;

  @override
  List<Object?> get props => [id];
}
