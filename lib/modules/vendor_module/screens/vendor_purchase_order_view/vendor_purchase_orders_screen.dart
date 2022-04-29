import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/models/enums/order_status.dart';
import 'package:emdad/modules/user_module/my_orders/orders_build_item.dart';
import 'package:emdad/modules/user_module/offers_module/title_with_filter_build_item.dart';
import 'package:emdad/modules/user_module/order_view/order_view_screen.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_offers_view/vendor_offers_cubit/vendor_offers_cubit.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/vendor_orders_details_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:flutter/material.dart';

class VendorPurchaseOrdersScreen extends StatelessWidget {
  const VendorPurchaseOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders =
        VendorOffersCubit.instance(context).offers; //TODO: Replace it
    return SingleChildScrollView(
      child: Column(
        children: [
          TitleWithFilterBuildItem(
            title: 'اوامر الشراء',
            changeSortType: (sortType) {},
            hasSort: false,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) => OrderBuildItem(
              order: orders[index],
              hasBadge: false,
              onTap: () {
                navigateTo(
                    context,
                    VendorOrderDetailsScreen(
                      title: 'طلب عرض سعر',
                      isCompleted: true,
                      orderId: orders[index].id,
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
