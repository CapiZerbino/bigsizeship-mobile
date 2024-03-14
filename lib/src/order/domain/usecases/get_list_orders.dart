import 'package:bigsizeship_mobile/core/usecase/usecase.dart';
import 'package:bigsizeship_mobile/core/utils/pagination.dart';
import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/order/data/models/order_model.dart';
import 'package:bigsizeship_mobile/src/order/domain/repositories/order_repository.dart';
import 'package:equatable/equatable.dart';

class GetListOrders
    extends UsecaseWithParams<List<OrderModel>, GetListOrdersParams> {
  const GetListOrders(this._repository);
  final OrderRepository _repository;

  @override
  ResultFuture<List<OrderModel>> call(GetListOrdersParams params) async =>
      _repository.getListOrders(status: params.status, filters: params.filters);
}

class GetListOrdersParams extends Equatable {
  const GetListOrdersParams({
    required this.status,
    required this.filters,
  });

  final String status;
  final CrudFilters filters;

  @override
  List<Object?> get props => [];
}
