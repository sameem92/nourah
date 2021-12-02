import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/home_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:provider/provider.dart';

import 'home_widget.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen>
    with SingleTickerProviderStateMixin, FbNotifications {
  List<Widget> _ScreensTab = [
    Obx(() {
      HomeGetx _homeGetx = Get.find();
      CategoriesGetX _categoriesGetX = Get.find();
      return HomeWidget(
        special: [],
        items: [],
      );
    }),
    Obx(() {
      HomeGetx _homeGetx = Get.find();
      CategoriesGetX _categoriesGetX = Get.find();
      return HomeWidget(
        special: [],
        items: [],
        family: true,
      );
    }),
    Obx(() {
      HomeGetx _homeGetx = Get.find();
      CategoriesGetX _categoriesGetX = Get.find();
      return HomeWidget(
        special: [],
        items: [],
        sales: true,
      );
    })
  ];
  int _selectedIndex = 1;
  late TabController _tabController;
  late TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    requestNotificationPermissions();
    search.addListener(() => setState(() {}));
    _tabController = TabController(length: _ScreensTab.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    search.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeGetx _homeGetx = Get.put(HomeGetx(
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      lat: "${Provider.of<LatNotiferUser>(context).latUser}",
      lng: "${Provider.of<LongNotiferUser>(context).longUser}",
    ));

    CategoriesGetX _categoriesGetX = Get.put(CategoriesGetX());
    return Scaffold(
      appBar: AppBarFamily(
        botoom: IconButton(
          icon: Icon(
            Provider.of<stringNotiferSearch>(context).search != ""
                ? Icons.refresh
                : Icons.search,
            size: fIconLarge,
            color: kSecondaryColor,
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();

            HomeGetx.to
                .filterProductsByName(name: search.text, context: context);
            Provider.of<stringNotiferSearch>(context, listen: false)
                .changeStringSearch(search.text);
            search.clear();
          },
        ),
        search: StyleField(
          padding: 0,
          filledBool: false,
          title: AppLocalizations.of(context)!.search,
          textAlign: TextAlign.center,
          controller: search,
        ),
        bottom: TabBar(
          controller: _tabController,
          onTap: (int selectedIndex) {
            selectedIndex = _selectedIndex;
          },
          padding: EdgeInsets.zero,
          labelColor: kSpecialColor.withOpacity(.8),
          indicatorWeight: SizeConfig.scaleHeight(3.0),
          unselectedLabelColor: kTextColor,
          labelPadding: EdgeInsets.only(bottom: 0, top: 0),
          indicatorColor: kSpecialColor,
          labelStyle: TextStyle(
            fontSize: fLarge,
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
      body: TabBarView(
        controller: _tabController,
        children: [
          Obx(() {
            return HomeWidget(
              special: _homeGetx.specialproducts.value.data,
              items: _homeGetx.products.value.data,
            );
          }),
          Obx(() {
            return HomeWidget(
              special: _homeGetx.specialfamilies.value.data,
              items: _homeGetx.families.value.data,
              family: true,
            );
          }),
          Obx(() {
            return HomeWidget(
              special: _homeGetx.specialoffers.value.data,
              items: _homeGetx.offers.value.data,
              sales: true,
            );
          })
        ],
      ),
    );
  }
}
