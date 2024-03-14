part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {
  const OrderInitial();
}

class GetListOrdersLoading extends OrderState {
  const GetListOrdersLoading();
}

class GetListOrdersSuccess extends OrderState {
  const GetListOrdersSuccess(this.orders);
  final List<Order> orders;

  @override
  List<Object> get props => [orders];
}

class GetListOrdersError extends OrderState {
  const GetListOrdersError(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
