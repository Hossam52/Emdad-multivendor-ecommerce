import 'package:emdad/layout/custom_drawer.dart';
import 'package:emdad/layout/transporter_layout/cubit/transporter_cubit.dart';
import 'package:emdad/layout/transporter_layout/cubit/transporter_state.dart';
import 'package:emdad/layout/transporter_layout/transporter_bottom_navigation_bar.dart';
import 'package:emdad/layout/user_layout/layout_components/drawer_list_build_item.dart';
import 'package:emdad/layout/widgets/profile_check_wrapper.dart';
import 'package:emdad/modules/transporter_module/transporter_cubits/transporter_offers_cubit/transporter_offers_cubit.dart';
import 'package:emdad/modules/transporter_module/transporter_cubits/transporter_purchase_orders_cubit/transporter_dlivery_orders_cubit.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class TransporterLayout extends StatefulWidget {
  const TransporterLayout({Key? key}) : super(key: key);

  @override
  State<TransporterLayout> createState() => _TransporterLayoutState();
}

class _TransporterLayoutState extends State<TransporterLayout> {
  @override
  void initState() {
    super.initState();
    final appCubit = AppCubit.get(context);

    appCubit.getUserProfile();
  }

  @override
  void deactivate() {
    AppCubit.get(context).removeCurrentUser();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileCheckWrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TransporterCubit(),
          ),
          BlocProvider(
            create: (context) => TransporterOffersCubit()..getOffers(),
          ),
          BlocProvider(
            create: (context) =>
                TransporterDeliveryOrdersCubit()..getDeliveryOrders(),
          ),
        ],
        child: BlocConsumer<TransporterCubit, TransporterState>(
          listener: (context, state) {},
          builder: (context, state) {
            TransporterCubit cubit = TransporterCubit.get(context);
            return DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(cubit.selectedBottom.title),
                  centerTitle: true,
                  leading: Builder(builder: (context) {
                    return IconButton(
                      icon: const Icon(
                        MyIcons.menu,
                        color: AppColors.primaryColor,
                        size: 18,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    );
                  }),
                  actions: [
                    IconButton(
                      icon: SvgPicture.asset(
                          '${Constants.defaultIconUrl}/notification.svg'),
                      onPressed: () {},
                    ),
                    const ChangeLangWidget(),
                  ],
                ),
                bottomNavigationBar:
                    TransporterBottomNavigationBar(cubit: cubit),
                drawer: const _TransporterDrawer(),
                body: cubit.selectedBottom.child,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TransporterDrawer extends StatelessWidget {
  const _TransporterDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = TransporterCubit.get(context);
    return CustomDrawer(
      drawerItems: [
        DrawerListBuildItem(
          title: 'الرئيسية',
          icon: MyIcons.home,
          onTap: () {
            cubit.changeToOffers();
          },
        ),
        DrawerListBuildItem(
          title: 'أوامر توصيل',
          icon: MyIcons.note,
          onTap: () {
            cubit.changeToPurchase();
          },
        ),
        DrawerListBuildItem(
          title: 'الاشعارات',
          icon: MyIcons.bell2,
          onTap: () {},
        ),
        DrawerListBuildItem(
          title: 'طلب مساعدة',
          icon: MyIcons.question,
          onTap: () {},
        ),
        DrawerListBuildItem(
          title: 'الدعم والخصوصية',
          icon: MyIcons.support,
          onTap: () {},
        ),
        DrawerListBuildItem(
          title: 'عنا',
          icon: Icons.info_outlined,
          size: 24,
          onTap: () {},
        ),
        DrawerListBuildItem(
          title: 'الضبط',
          icon: MyIcons.settings,
          onTap: () {
            cubit.changeToSettings();
          },
        ),
      ],
    );
  }
}
