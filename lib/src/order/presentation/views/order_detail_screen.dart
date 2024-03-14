import 'package:bigsizeship_mobile/core/resources/colours.dart';
import 'package:bigsizeship_mobile/src/order/domain/entities/carrier.dart';
import 'package:bigsizeship_mobile/src/order/domain/entities/order.dart';
import 'package:bigsizeship_mobile/src/order/presentation/widgets/description_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  static const routeName = '/orderDetail';

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments! as Order;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đơn hàng'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              OrderGeneralInformation(
                order: order,
              ),
              ProductInformation(
                order: order,
              ),
              PriceInformation(
                order: order,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderGeneralInformation extends StatelessWidget {
  const OrderGeneralInformation({required Order order, super.key})
      : _order = order;

  final Order _order;

  String getLogoCarrier(Carrier? carrier) {
    debugPrint('Carrier: ${carrier?.name}');
    switch (carrier?.name) {
      case 'NINJAVAN':
        return 'NJV_logo';
      case 'GHN':
        return 'GHN_logo';
      case 'GHTK':
        return 'GHTK_logo';
      case 'BEST_EXPRESS':
        return 'NJV_logo';
      default:
        return 'NJV_logo';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Image(
                width: 36,
                height: 36,
                image: AssetImage(
                  'assets/images/${getLogoCarrier(_order.carrier)}.png',
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mã vận đơn: ${_order.id}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Text('SAO CHÉP'),
                    ],
                  ),
                  Text('Ngày tạo: ${DateFormat.yMd().format(
                    DateTime.parse(
                      _order.createdAt.toString(),
                    ),
                  )}'),
                  Text('Giao bởi: ${_order.carrier?.name}'),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                    Icon(Icons.location_pin, color: Colors.green),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_order.fromName},${_order.fromPhoneNumber}',
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${_order.fromAddress},${_order.fromWard},${_order.fromDistrict},${_order.fromProvince}',
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // concat fromName and fromAddress
                          Text(
                            '${_order.toName},${_order.toPhoneNumber}',
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${_order.toAddress},${_order.toWard},${_order.toDistrict},${_order.toProvince}',
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colours.primaryColour,
              ),
              foregroundColor: MaterialStateProperty.all<Color>(
                Colors.white,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            onPressed: null,
            child: Text(_order.status),
          ),
          const Text(
            'Không thể huỷ đơn đang vận chuyển',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ProductInformation extends StatelessWidget {
  const ProductInformation({required Order order, super.key}) : _order = order;

  final Order _order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Thông tin sản phẩm',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DescriptionItem(
                icon: Icons.production_quantity_limits,
                label: 'Sản phẩm',
                value: _order.productName.toString(),
              ),
              DescriptionItem(
                icon: Icons.monitor_weight,
                label: 'Khối lượng',
                value: _order.weight.toString(),
              ),
              DescriptionItem(
                icon: Icons.sanitizer_sharp,
                label: 'Kích thước',
                value: _order.productName.toString(),
              ),
              DescriptionItem(
                icon: Icons.price_check,
                label: 'Giá trị kiện hàng',
                value: _order.parcelValue.toString(),
              ),
              DescriptionItem(
                icon: Icons.code,
                label: 'Mã đơn hàng riêng',
                value: _order.merchantOrderNumber.toString(),
              ),
              DescriptionItem(
                icon: Icons.shopping_bag,
                label: 'Đơn giao 1 phần',
                value: _order.isPartialReturned ? 'Có' : 'Không',
              ),
              DescriptionItem(
                icon: Icons.note_alt_outlined,
                label: 'Chú thích',
                value: _order.deliveryInstructions.toString(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PriceInformation extends StatelessWidget {
  const PriceInformation({required Order order, super.key}) : _order = order;

  final Order _order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Phí dịch vụ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DescriptionItem(
                icon: Icons.production_quantity_limits,
                label: 'Phí vận chuyển',
                value: _order.shipmentFee.toString(),
              ),
              DescriptionItem(
                icon: Icons.monitor_weight,
                label: 'Phí thu hộ',
                value: _order.cashOnDeliveryFee.toString(),
              ),
              DescriptionItem(
                icon: Icons.sanitizer_sharp,
                label: 'Phí bảo hiểm',
                value: _order.insuranceFee.toString(),
              ),
              DescriptionItem(
                icon: Icons.price_check,
                label: 'Phí đổi địa chỉ',
                value: _order.changeFee.toString(),
              ),
              DescriptionItem(
                icon: Icons.code,
                label: 'Phí khác',
                value: _order.otherFee.toString(),
              ),
              const Divider(),
              const DescriptionItem(
                showIcon: false,
                icon: Icons.note_alt_outlined,
                label: 'Tổng cước',
                value: '100.000',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
