import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/add.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/categories.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/products.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/family_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';

class StoreFamily extends StatefulWidget {
  @override
  _StoreFamilyState createState() => _StoreFamilyState();
}

class _StoreFamilyState extends State<StoreFamily>
    with SingleTickerProviderStateMixin {
  List<Widget> screensTab = [
    ProductsFamily(),
    Add(),
    Categories(),
  ];
  int selectedIndex = 0;
  late TabController _tabController;
  GetProductsFamilyGetx controller = Get.put(GetProductsFamilyGetx());
  GetCategoriesFamilyGetx cont = Get.put(GetCategoriesFamilyGetx());

  @override
  void initState() {
    super.initState();
    managenotificationAction(context);

    _tabController = TabController(length: screensTab.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<GetProductsFamilyGetx>();
    Get.delete<GetCategoriesFamilyGetx>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTaps(
        context,
        tabController: _tabController,
        selectedIndexx: selectedIndex = 0,
        tap1: AppLocalizations.of(context)!.productsOffers,
        tap2: AppLocalizations.of(context)!.addProductsOffers,
        tap3: AppLocalizations.of(context)!.categories,
        tap3Exist: true,
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
                          backgroundColor: kSpecialColor, onPressed: () async {
                        await network.refreshData();
                      })
                    ],
                  )
                : TabBarView(
                    controller: _tabController,
                    children: [
                      ProductsFamily(),
                      Add(),
                      Categories(),
                    ],
                  );
          }),
    );
  }
}
