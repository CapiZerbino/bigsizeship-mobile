import 'package:bigsizeship_mobile/src/order/domain/entities/order.dart';
import 'package:bigsizeship_mobile/src/order/domain/usecases/get_list_orders.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({
    required GetListOrders getListOrders,
  })  : _getListOrders = getListOrders,
        super(const OrderInitial()) {
    on<OrderEvent>((event, emit) {
      emit(const GetListOrdersLoading());
    });

    on<GetListOrdersEvent>(_getListOrdersHandler);
  }

  final GetListOrders _getListOrders;

  final List<Order> _orders = [];

  Future<void> _getListOrdersHandler(
    GetListOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    final result = await _getListOrders(
      const GetListOrdersParams(
        status: 'status',
        filters: [],
      ),
    );

    _orders.addAll(result.getOrElse(() => []));
    result.fold(
      (failure) => emit(GetListOrdersError(failure.errorMessage)),
      (orders) => emit(GetListOrdersSuccess(orders)),
    );
  }
}
