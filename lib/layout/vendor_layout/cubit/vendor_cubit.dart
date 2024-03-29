import 'dart:io';

import 'package:emdad/layout/widgets/custom_bottom_nav_item.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:emdad/models/general_models/product_detailes.dart';
import 'package:emdad/modules/settings/setting_screen.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_offers_view/vendor_offers_screen.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_products_screen.dart';
import 'package:emdad/modules/vendor_module/screens/vendor_purchase_order_view/vendor_purchase_orders_screen.dart';
import 'package:emdad/shared/network/services/vendor/vendor_services.dart';

part 'vendor_state.dart';

//Bloc builder and bloc consumer methods
typedef VendorBlocBuilder = BlocBuilder<VendorCubit, VendorStates>;
typedef VendorBlocConsumer = BlocConsumer<VendorCubit, VendorStates>;

//
class VendorCubit extends Cubit<VendorStates> {
  VendorCubit(BuildContext context) : super(IntitalVendorState()) {
    bottomItems = [
      CustomBottomNavItemModel(
        child: VendorOffersScreen(),
        title: context.tr.orders_price_offer,
        icon: Icons.show_chart_outlined,
      ),
      CustomBottomNavItemModel(
        child: const VendorProductsScreen(),
        title: context.tr.my_products,
        icon: Icons.shopping_cart_outlined,
      ),
      CustomBottomNavItemModel(
        child: const VendorPurchaseOrdersScreen(),
        title: context.tr.purchase_orders_requests,
        icon: Icons.how_to_reg_outlined,
      ),
      CustomBottomNavItemModel(
        child: const SettingsScreen(),
        title: context.tr.settings,
        icon: MyIcons.settings,
      ),
    ];
  }
  static VendorCubit instance(BuildContext context) =>
      BlocProvider.of<VendorCubit>(context);
  final vendorServices = VendorServices.instance;
  late List<CustomBottomNavItemModel> bottomItems;

  int currentPageIndex = 0;

  CustomBottomNavItemModel get selectedBottomItem =>
      bottomItems[currentPageIndex];
  void changeToOffers() {
    changeIndex(0);
  }

  void changeToProducts() {
    changeIndex(1);
  }

  void changeToPurchase() {
    changeIndex(2);
  }

  void chnageeToSettings() {
    changeIndex(3);
  }

  void changeIndex(int index) {
    currentPageIndex = index;
    emit(ChangeBottomNavBarState());
  }
}
