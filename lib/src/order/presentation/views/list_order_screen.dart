import 'package:bigsizeship_mobile/core/common/widgets/gradient_background.dart';
import 'package:bigsizeship_mobile/core/resources/colours.dart';
import 'package:bigsizeship_mobile/core/resources/media_resources.dart';
import 'package:bigsizeship_mobile/src/order/domain/entities/carrier.dart';
import 'package:bigsizeship_mobile/src/order/domain/entities/order.dart';
import 'package:bigsizeship_mobile/src/order/presentation/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ListOrderScreen extends StatefulWidget {
  const ListOrderScreen({super.key});

  static const routeName = '/listOrder';

  @override
  State<ListOrderScreen> createState() => _ListOrderScreenState();
}

class _ListOrderScreenState extends State<ListOrderScreen> {
  List<Order> listOrder = [];

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(const GetListOrdersEvent());
  }

  //function to get icon name
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách đơn hàng'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colours.primaryColour,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/createOrder');
            },
          ),
        ],
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (_, state) {
          if (state is GetListOrdersSuccess) {
            listOrder = state.orders;
          }
        },
        builder: (context, state) {
          return GradientBackground(
            image: MediaResources.whiteBackground,
            child: SafeArea(
              child: Center(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: listOrder.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/orderDetail',
                            arguments: listOrder[index],
                          );
                        },
                        title: Text(
                          listOrder[index].trackingId,
                          style: const TextStyle(
                            color: Colours.primaryColour,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('Thời gian: '),
                                Text(
                                  DateFormat.yMd().format(
                                    DateTime.parse(
                                      listOrder[index].createdAt.toString(),
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: Colours.neutralTextColour,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Khách: '),
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                    listOrder[index].toName.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colours.neutralTextColour,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Trạng thái: '),
                                Text(
                                  listOrder[index].status,
                                  style: const TextStyle(
                                    color: Colours.neutralTextColour,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Cước: '),
                                Text(
                                  listOrder[index].shipmentFee.toString(),
                                  style: const TextStyle(
                                    color: Colours.primaryColour,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        leading: Image(
                          width: 36,
                          height: 36,
                          image: AssetImage(
                            'assets/images/${getLogoCarrier(listOrder[index].carrier)}.png',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
