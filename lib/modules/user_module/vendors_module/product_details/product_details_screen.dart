import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/modules/user_module/vendors_module/product_details/product_cubit.dart/product_cubit.dart';
import 'package:emdad/modules/user_module/vendors_module/product_details/product_cubit.dart/product_states.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/cart_cubit/cart_cubit.dart';
import 'package:emdad/modules/vendor_module/screens/vender_add_product_view/vendor_edit_product_screen.dart';
import 'package:emdad/modules/vendor_module/vendor_cubits/products_cubit/vendor_product_cubit.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/responsive/responsive_widget.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/dialogs/add_to_price_request_dialog.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'product_custom_tile.dart';
import 'size_build_item.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({
    Key? key,
    required this.isVendor,
    required this.productId,
  }) : super(key: key);
  final String? productId;
  final bool isVendor;

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) =>
            ProductCubit(productId: productId!, isVendor: isVendor)
              ..getProduct(),
        child: ProductBlocBuilder(
          builder: (context, state) {
            final productCubit = ProductCubit.instance(context);
            if (state is GetProductLoadingState) {
              return const DefaultLoader();
            }
            if (state is GetProductErrorState) {
              return NoDataWidget(
                  onPressed: () {
                    productCubit.getProduct();
                  },
                  text: state.error);
            }
            if (!productCubit.loadedProduct) {
              return NoDataWidget(
                  onPressed: () {
                    productCubit.getProduct();
                  },
                  text: 'No product try again');
            }

            final product = productCubit.product;
            return responsiveWidget(
              responsive: (_, deviceInfo) => Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: isVendor
                    ? null
                    : _AddToPriceOffer(
                        product: product,
                      ),
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      flexibleSpace: FlexibleSpaceBar(
                        background: _ProductImages(
                            pageController: pageController, product: product),
                      ),
                      pinned: true,
                      expandedHeight: 250.h,
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(Icons.close, size: 20),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            foregroundColor: AppColors.thirdColor,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon:
                                  Icon(isVendor ? Icons.edit : null, size: 20),
                              onPressed: () async {
                                if (isVendor) {
                                  final hasUpdateData = await navigateTo(
                                      context,
                                      VendorEditProductScreen(
                                        product: product,
                                      ));
                                  print(hasUpdateData);
                                  if (hasUpdateData != null && hasUpdateData) {
                                    productCubit.getProduct();
                                    VendorProductsCubit.instance(context)
                                        .getAllVendorProducts();
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        const ChangeLangWidget(
                          color: Colors.white,
                        ),
                      ],
                      systemOverlayStyle: const SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                        statusBarBrightness: Brightness.light,
                        statusBarIconBrightness: Brightness.light,
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Text(product.name, style: headersTextStyle()),
                            const SizedBox(height: 5),
                            Text(
                                product
                                    .productType, // 'الرحمه للمواد الغذائية',
                                style: thirdTextStyle()
                                    .copyWith(color: AppColors.thirdColor)),
                            const SizedBox(height: 20),
                            ProductCustomTile(
                              title: 'تفاصيل المنتج',
                              children: [
                                Text(
                                  product.description,
                                  style: thirdTextStyle()
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ProductCustomTile(
                              title: 'وحدات القياس',
                              children: [
                                Container(
                                  color: Colors.grey.shade900.withOpacity(0.5),
                                  child: const SizeBuildItem(
                                    title: 'وحدة القياس',
                                    value: 'الحد الادني',
                                    price: 'سعر الوحدة',
                                  ),
                                ),
                                for (int i = 0; i < product.units.length; i++)
                                  Container(
                                    color: AppColors.primaryColor
                                        .withOpacity(i.isEven ? 0.2 : 0.4),
                                    child: SizeBuildItem(
                                        title: product.units[i].productUnit,
                                        value: product
                                            .units[i].minimumAmountPerOrder
                                            .toString(),
                                        price: getPrice(
                                            product, product.units[i])),
                                  ),
                                // ...product.units
                                //     .map(
                                //       (unit) => Container(
                                //         color: AppColors.primaryColor
                                //             .withOpacity(2.isEven ? 0.2 : 0.4),
                                //         child: SizeBuildItem(
                                //             title: unit.productUnit,
                                //             value: unit.minimumAmountPerOrder
                                //                 .toString(),
                                //             price: getPrice(product, unit)),
                                //       ),
                                //     )
                                //     .toList()
                              ],
                            ),
                            const SizedBox(height: 210),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String getPrice(ProductModel product, ProductUnit unit) {
    final pricePerUnit = unit.pricePerUnit;
    if (isVendor) {
      return pricePerUnit.toString();
    } else {
      return product.isPriceShown ? unit.pricePerUnit.toString() : 'السعر مخفي';
    }
  }
}

class _ProductImages extends StatelessWidget {
  const _ProductImages({
    Key? key,
    required this.pageController,
    required this.product,
  }) : super(key: key);

  final PageController pageController;
  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          controller: pageController,
          itemCount: product!.imagesUrls.length,
          scrollDirection: Axis.horizontal,
          physics: const PageScrollPhysics(),
          itemBuilder: (context, index) => DefaultCachedNetworkImage(
            imageUrl: product!.imagesUrls[index],
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: SmoothPageIndicator(
            controller: pageController,
            count: product!.imagesUrls.length,
            effect: const ScrollingDotsEffect(
              dotWidth: 8,
              dotHeight: 8,
              activeDotColor: AppColors.thirdColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _AddToPriceOffer extends StatefulWidget {
  const _AddToPriceOffer({Key? key, required this.product}) : super(key: key);
  final ProductModel product;
  @override
  State<_AddToPriceOffer> createState() => _AddToPriceOfferState();
}

class _AddToPriceOfferState extends State<_AddToPriceOffer> {
  final TextEditingController quantityController =
      TextEditingController(text: '1');
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            enableDrag: true,
            builder: (_) => BlocProvider.value(
                  value: CartCubit.instance(context),
                  child: AddToPriceRequestDialog(
                    product: widget.product,
                  ),
                ));
      },
      label: const Text('إضافة إلى طلب عرض السعر'),
      icon: const Icon(Icons.add_shopping_cart),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: AppColors.secondaryColor,
      extendedIconLabelSpacing: 20,
    );
  }
}
