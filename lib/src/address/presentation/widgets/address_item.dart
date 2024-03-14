import 'package:bigsizeship_mobile/src/address/domain/entities/address.dart';
import 'package:bigsizeship_mobile/src/order/presentation/widgets/description_item.dart';
import 'package:flutter/material.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({
    super.key,
    required this.address,
    required this.index,
  });

  final Address address;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          'Kho hàng ${index + 1}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          children: [
            DescriptionItem(
              showIcon: false,
              icon: Icons.abc,
              label: 'Số điện thoại',
              value: address.phoneNumber,
            ),
            DescriptionItem(
              showIcon: false,
              icon: Icons.abc,
              label: 'Địa chỉ',
              value:
                  '${address.address}, ${address.ward}, ${address.address}, ${address.province}',
            ),
          ],
        ),
      ),
    );
  }
}
