import 'dart:developer';

import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_cubit.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/all_orders_list_view.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_out_of_products.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_total_overview_price.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_total_row_item.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_vendor_info.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_widget_wrapper.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/shipping_widget.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCompletedScreen extends StatelessWidget {
  const OrderCompletedScreen({
    Key? key,
    required this.title,
    required this.status,
    required this.orderId,
  }) : super(key: key);

  final OrderStatus status;
  final String orderId;
  final String title;

  @override
  Widget build(BuildContext context) {
    log(status.toString());
    return BlocProvider(
      create: (context) => OrderCubit(orderId: orderId)..getOrder(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title, style: const TextStyle(color: Colors.white)),
          backgroundColor: AppColors.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
          actions: const [
            ChangeLangWidget(
              color: Colors.white,
            )
          ],
        ),
        body: OrderWidgetWrapper(
          child: Builder(
            builder: (context) {
              final order = OrderCubit.instance(context).order;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    OrderVendorInfo(vendor: order.vendor),
                    AllOrdersListView(
                      vendorId: order.vendorId,
                    ),
                    const SizedBox(height: 36),
                    const OrderOutOfProducts(),
                    const SizedBox(height: 20),
                    ShippingWidget(
                        transportationHandler: order.transportationHandlerEnum,
                        transportationRequest: order.transportationRequest),
                    const SizedBox(height: 20),
                    DefaultHomeTitleBuildItem(
                      title: 'إجمالي',
                      onPressed: () {},
                      hasButton: false,
                    ),
                    const OrderTotalOverviewPrice(children: [
                      OrderTotalRowItem(title: 'الضريبة', value: '١٢٪'),
                      SizedBox(height: 10),
                      OrderTotalRowItem(title: 'الشحن', value: '1150 ر.س'),
                      SizedBox(height: 10),
                      OrderTotalRowItem(
                          title: 'إجمالي', value: '٩٠٩٠ ريال سعودي'),
                    ]),
                    const SizedBox(height: 50),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
