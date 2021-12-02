import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/add.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/categories.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/products.dart';
import 'package:producer_family_app/storage/providersAndGetx/family_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoreFamily extends StatefulWidget {
  @override
  _StoreFamilyState createState() => _StoreFamilyState();
}

class _StoreFamilyState extends State<StoreFamily>
    with SingleTickerProviderStateMixin {
  List<Widget> _ScreensTab = [
    products(),
    Add(),
    Categories(),
  ];
  int _selectedIndex = 0;
  late TabController _tabController;
  getProductsFamilyGetx controller = Get.put(getProductsFamilyGetx());
  getCategoriesFamilyGetx cont = Get.put(getCategoriesFamilyGetx());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _ScreensTab.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBar_taps(
        context,
        tabController: _tabController,
        selectedIndexx: _selectedIndex = 0,
        tap1: AppLocalizations.of(context)!.productsOffers,
        tap2: AppLocalizations.of(context)!.addProductsOffers,
        tap3: AppLocalizations.of(context)!.categories,
        tap3Exist: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          products(),
          Add(),
          Categories(),
        ],
      ),
    );
  }
}
