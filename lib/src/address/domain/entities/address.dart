import 'package:equatable/equatable.dart';

enum AddressType {
  SENDER,
  RECEIVER,
}

extension AddressExt on AddressType {
// tên không phải tiếng Anh
  String get name {
    switch (this) {
      case AddressType.SENDER:
        return 'SENDER';
      case AddressType.RECEIVER:
        return 'RECEIVER';
    }
  }
}

class Address extends Equatable {
  const Address({
    required this.id,
    required this.address,
    required this.province,
    required this.provinceCode,
    required this.district,
    required this.districtCode,
    required this.ward,
    required this.wardCode,
    required this.name,
    required this.phoneNumber,
    required this.isDefault,
    required this.addressType,
  });

  final int id;
  final String address;
  final String province;
  final String provinceCode;
  final String district;
  final String districtCode;
  final String ward;
  final String wardCode;
  final String name;
  final String phoneNumber;
  final bool isDefault;
  final AddressType addressType;

  @override
  List<Object?> get props => [id, name];
}
