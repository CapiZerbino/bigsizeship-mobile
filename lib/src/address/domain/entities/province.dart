import 'package:equatable/equatable.dart';

class Province extends Equatable {
  const Province({
    required this.id,
    required this.provinceId,
    required this.name,
  });

  final int id;
  final String provinceId;
  final String name;

  @override
  List<Object?> get props => [id, provinceId];
}
