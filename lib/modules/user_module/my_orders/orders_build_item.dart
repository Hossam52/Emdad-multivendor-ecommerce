import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';

class OrderBuildItem extends StatelessWidget {
  const OrderBuildItem({
    Key? key,
    required this.hasBadge,
    required this.onTap,
    required this.order,
    this.trailing,
  }) : super(key: key);
  final SupplyRequest order;
  final bool hasBadge;
  final Function() onTap;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(bottom: 20),
      shadowColor: Colors.black.withOpacity(0.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 53.w,
                height: 53.w,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: DefaultCachedNetworkImage(
                  imageUrl: order.vendor.logoUrl, // image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 13.5.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.id,
                      // order.vendor.oraganizationName,
                      style: thirdTextStyle().copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      SharedMethods.mappedDate(order.createdAt),
                      style: subTextStyle(),
                    ),
                    if (hasBadge)
                      Chip(
                        label: Text(
                            order.vendorProvidePriceOffer
                                ? order.totalOrderPrice.toString()
                                : 'لم يتم اضافة عرض',
                            style: subTextStyle()
                                .copyWith(color: AppColors.errorColor)),
                        backgroundColor:
                            AppColors.primaryColor.withOpacity(0.15),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    if (trailing != null) trailing!,
                  ],
                ),
              ),
              RawMaterialButton(
                onPressed: () {},
                child: const Icon(Icons.arrow_forward_ios, size: 12),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                constraints: const BoxConstraints(minWidth: 0),
                padding: const EdgeInsets.all(6),
                fillColor: Colors.white54,
                shape: const CircleBorder(),
                elevation: 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
