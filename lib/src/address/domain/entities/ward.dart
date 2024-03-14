import 'package:bigsizeship_mobile/src/address/domain/entities/district.dart';
import 'package:equatable/equatable.dart';

class Ward extends Equatable {
  Ward({
    required this.id,
    required this.wardId,
    required this.name,
    this.district,
  });

  final int id;
  final String wardId;
  final String name;
  District? district;

  @override
  List<Object?> get props => [id, wardId];
}
