import 'dart:convert';

import 'package:bigsizeship_mobile/core/services/api_request.dart';
import 'package:bigsizeship_mobile/core/utils/pagination.dart';
import 'package:bigsizeship_mobile/src/order/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  const OrderRemoteDataSource();

  Future<List<OrderModel>> getListOrders({
    required String status,
    required CrudFilters filters,
  });
}

class OrderRemoteDataSourceImplementation implements OrderRemoteDataSource {
  const OrderRemoteDataSourceImplementation();
  @override
  Future<List<OrderModel>> getListOrders({
    required String status,
    required CrudFilters filters,
  }) async {
    try {
      // Mock data
      // final jsonString = await loadJsonAsset('order-original');
      // final data = jsonDecode(jsonString);

      final CrudFilters newFilters = [];
      if (status != '') {
        newFilters.add(
          CrudFilter(
            field: 'status',
            operator: CrudOperators.eq,
            value: [status],
          ),
        );
      }

      // Call Api
      final result = await ApiRequest().getList(
        resource: 'v1/orders',
        pagination: Pagination(
          current: 1,
          pageSize: 30,
        ),
        filters: [...newFilters, ...filters],
        sorters: [],
      );

      final orders = result.data
          .map((item) => OrderModel.fromJson(jsonEncode(item)))
          .toList();
      return orders;
    } catch (e) {
      throw Exception(e);
    }
  }
}
