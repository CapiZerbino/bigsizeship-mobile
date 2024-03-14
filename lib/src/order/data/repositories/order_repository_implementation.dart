import 'package:bigsizeship_mobile/core/errors/exception.dart';
import 'package:bigsizeship_mobile/core/errors/failure.dart';
import 'package:bigsizeship_mobile/core/utils/pagination.dart';
import 'package:bigsizeship_mobile/core/utils/typedef.dart';
import 'package:bigsizeship_mobile/src/order/data/datasources/order_remote_date_source.dart';
import 'package:bigsizeship_mobile/src/order/data/models/order_model.dart';
import 'package:bigsizeship_mobile/src/order/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';

class OrderRepositoryImplementation implements OrderRepository {
  const OrderRepositoryImplementation(this._remoteDataSource);
  final OrderRemoteDataSource _remoteDataSource;
  @override
  ResultFuture<List<OrderModel>> getListOrders({
    required String status,
    required CrudFilters filters,
  }) async {
    try {
      final listOrder = await _remoteDataSource.getListOrders(
        status: status,
        filters: filters,
      );
      return Right(listOrder);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
