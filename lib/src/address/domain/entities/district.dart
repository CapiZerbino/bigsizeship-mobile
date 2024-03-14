import 'package:bigsizeship_mobile/src/address/domain/entities/province.dart';
import 'package:equatable/equatable.dart';

class District extends Equatable {
  District({
    required this.id,
    required this.districtId,
    required this.name,
    this.province,
  });

  final int id;
  final String districtId;
  final String name;
  Province? province;

  @override
  List<Object?> get props => [id, districtId];
}
