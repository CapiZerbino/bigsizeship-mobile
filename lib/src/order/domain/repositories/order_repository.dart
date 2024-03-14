import 'package:bigsizeship_mobile/core/utils/pagination.dart';
import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/order/data/models/order_model.dart';

abstract class OrderRepository {
  const OrderRepository();

  ResultFuture<List<OrderModel>> getListOrders({
    required String status,
    required CrudFilters filters,
  });
}
