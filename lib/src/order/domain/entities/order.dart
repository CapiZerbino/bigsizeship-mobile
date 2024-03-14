import 'package:bigsizeship_mobile/src/authentication/domain/entities/user.dart';
import 'package:bigsizeship_mobile/src/order/domain/entities/carrier.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  const Order({
    required this.id,
    required this.trackingId,
    required this.status,
    this.cashOnDelivery,
    this.cashOnDeliveryFee,
    this.insuranceFee,
    this.changeFee,
    this.shipmentFee,
    this.otherFee,
    this.fromName,
    this.fromPhoneNumber,
    this.fromAddress,
    this.fromDistrict,
    this.fromDistrictCode,
    this.fromProvince,
    this.fromProvinceCode,
    this.fromWard,
    this.fromWardCode,
    this.toName,
    this.toPhoneNumber,
    this.toAddress,
    this.toDistrict,
    this.toDistrictCode,
    this.toProvince,
    this.toProvinceCode,
    this.toWard,
    this.toWardCode,
    this.height,
    this.length,
    this.weight,
    this.width,
    this.deliveryInstructions,
    this.customer,
    required this.isPartialReturned,
    required this.isReconciled,
    this.merchantOrderNumber,
    this.createdAt,
    this.updatedAt,
    this.endDate,
    this.productName,
    this.parcelValue,
    this.carrier,
  });

  final int id;
  final String trackingId;
  final String status;
  final double? cashOnDelivery;
  final double? cashOnDeliveryFee;
  final double? insuranceFee;
  final double? changeFee;
  final double? shipmentFee;
  final double? otherFee;
  final String? fromName;
  final String? fromPhoneNumber;
  final String? fromAddress;
  final String? fromDistrict;
  final String? fromDistrictCode;
  final String? fromProvince;
  final String? fromProvinceCode;
  final String? fromWard;
  final String? fromWardCode;
  final String? toName;
  final String? toPhoneNumber;
  final String? toAddress;
  final String? toDistrict;
  final String? toDistrictCode;
  final String? toProvince;
  final String? toProvinceCode;
  final String? toWard;
  final String? toWardCode;
  final double? height;
  final double? length;
  final double? weight;
  final double? width;
  final String? deliveryInstructions;
  final User? customer;
  final bool isPartialReturned;
  final bool isReconciled;
  final String? merchantOrderNumber;
  final String? createdAt;
  final String? updatedAt;
  final String? endDate;
  final String? productName;
  final double? parcelValue;
  final Carrier? carrier;

  @override
  List<Object?> get props => [id, trackingId];
}
