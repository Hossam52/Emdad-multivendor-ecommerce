import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/models/users/user/supply_requests/order_request_model.dart';
import 'package:emdad/shared/network/services/user/user_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import './order_states.dart';

//Bloc builder and bloc consumer methods
typedef OrderBlocBuilder = BlocBuilder<OrderCubit, OrderStates>;
typedef OrderBlocConsumer = BlocConsumer<OrderCubit, OrderStates>;

//
class OrderCubit extends Cubit<OrderStates> {
  OrderCubit({required this.orderId}) : super(IntitalOrderState());
  static OrderCubit instance(BuildContext context) =>
      BlocProvider.of<OrderCubit>(context);
  final String orderId;
  final _services = UserServices.instance;
  OrderRequestModel? _orderDetails;
  bool get emtpyOrder => _orderDetails == null;
  SupplyRequest get order => _orderDetails!.supplyRequest;
  Future<void> getOrder() async {
    try {
      emit(GetOrderLoadingState());
      final map = await _services.requestServices.getOrder(orderId: orderId);
      _orderDetails = OrderRequestModel.fromMap(map);
      emit(GetOrderSuccessState());
    } catch (e) {
      emit(GetOrderErrorState(error: e.toString()));
    }
  }
}