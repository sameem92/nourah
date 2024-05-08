import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/home/products_tab.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/home/sales_tab.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/home_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:provider/provider.dart';

import 'family_tab.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen>
    with SingleTickerProviderStateMixin, FbNotifications {
  List<Widget> screensTab = [
    ProductsTab(),
    FamilyTab(),
    SalesTab(),
  ];
  int _selectedIndex = 1;
  late TabController _tabController;
  late TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    Get.delete<getMakeOrderIdGetx>();
    requestNotificationPermissions();
    managenotificationAction(context);
    initializeForegroundNotificationForAndroid();
    search.addListener(() => setState(() {}));
    _tabController = TabController(length: screensTab.length, vsync: this);
    _tabController.addListener(() {
      if (!mounted) {
      } else {
        setState(() {
          _selectedIndex = _tabController.index;
          // print(_selectedIndex);
        });
      }
    });

    _tabController.animateTo(
        Provider.of<intIndexTabHome>(context, listen: false).intIndex != 0
            ? Provider.of<intIndexTabHome>(context, listen: false).intIndex
            : 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    search.dispose();
    _tabController.dispose();
    super.dispose();

    // Get.delete<HomeGetx>();
  }

  @override
  Widget build(BuildContext context) {
    HomeGetx homeGetx = Get.put(HomeGetx(
      context: context,
    ));
    return Scaffold(
        appBar: AppBarFamily(
          botoom: IconButton(
            icon: Icon(
              Icons.search,
              size: fIconLarge,
              color: kTextColor,
            ),
            onPressed: () {
              if (search.text.isNotEmpty) {
                FocusScope.of(context).unfocus();
                HomeGetx.to.filterProductsByName(
                    name: search.text,
                    context: context,
                    categoryId:
                        Provider.of<intCategoryId>(context, listen: false)
                            .categoryId);

                Provider.of<stringNotiferSearch>(context, listen: false)
                    .changeStringSearch(search.text);
              }
            },
          ),
          search: StyleField(
            padding: 0,
            maxLines: 3,
            height: 1,
            filledBool: false,
            title: AppLocalizations.of(context)!.search,
            textAlign: TextAlign.center,
            controller: search,
            onPressedClose: () {
              Provider.of<stringNotiferSearch>(context, listen: false)
                  .changeStringSearch("");
              homeGetx.filterProductsByCategory(
                  categoryId: Provider.of<intCategoryId>(context, listen: false)
                      .categoryId,
                  name: "");
            },
          ),
          bottom: TabBar(
            controller: _tabController,
            onTap: (int selectedIndex) {
              selectedIndex = _selectedIndex;
              // print(_selectedIndex);
              Provider.of<intIndexTabHome>(context, listen: false)
                  .changeIntIndexTabHome(_selectedIndex);
            },
            padding: EdgeInsets.zero,
            labelColor: kSpecialColor,
            indicatorWeight: SizeConfig.scaleHeight(3.0),
            unselectedLabelColor: kTextColor,
            labelPadding: const EdgeInsets.only(bottom: 0, top: 0),
            indicatorColor: kSpecialColor,
            labelStyle: TextStyle(
              fontSize: SizeConfig.scaleHeight(24),
              fontFamily: "ElMessiri",
            ),
            tabs: [
              Tab(
                text: AppLocalizations.of(context)!.products,
              ),
              Tab(
                text: AppLocalizations.of(context)!.producerfamilies,
              ),
              Tab(
                text: AppLocalizations.of(context)!.sales,
              ),
            ],
          ),
        ),
        body: GetX<GetNetworkGetx>(
            init: GetNetworkGetx(),
            builder: (GetNetworkGetx network) {
              return network.connectionType.value == 0
                  ? Column(
                      children: [
                        noContent(
                            context, AppLocalizations.of(context)!.noInternet),
                        SizedBox(
                          height: SizeConfig.scaleHeight(30),
                        ),
                        StyleButton(AppLocalizations.of(context)!.refresh,
                            sideColor: kSpecialColor,
                            backgroundColor: kSpecialColor,
                            onPressed: () async {
                          await network.refreshData();
                        })
                      ],
                    )
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        ProductsTab(),
                        FamilyTab(),
                        SalesTab(),
                      ],
                    );
            }));
  }
}
