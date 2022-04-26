import 'package:emdad/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:emdad/modules/user_module/my_orders/orders_build_item.dart';
import 'package:emdad/modules/user_module/offers_module/title_with_filter_build_item.dart';
import 'package:emdad/modules/user_module/order_view/shipping/shipping_offer_details.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:flutter/material.dart';

class ShippingOffersScreen extends StatelessWidget {
  const ShippingOffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عروض التوصيل'),
        actions: const [ChangeLangWidget(color: Colors.black)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TitleWithFilterBuildItem(title: 'عروض التوصيل'),
            ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => OrderBuildItem(
                order: VendorCubit.instance(context)
                    .allVendorRequests!
                    .supplyRequests
                    .first, //Replace it

                hasBadge: false,
                trailing: const Text('عربه نصف نقل'),
                onTap: () {
                  navigateTo(context, const ShippingOfferDetails());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
