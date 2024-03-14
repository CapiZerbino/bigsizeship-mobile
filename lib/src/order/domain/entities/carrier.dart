import 'package:equatable/equatable.dart';

class Carrier extends Equatable {
  const Carrier({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
