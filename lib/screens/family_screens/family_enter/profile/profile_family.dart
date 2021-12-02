import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/screens/public_screens/profile_screen.dart';
import 'package:producer_family_app/storage/providersAndGetx/family_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/login_profile_getx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../public_screens/administration.dart';

class ProfileFamily extends StatefulWidget {
  @override
  _ProfileFamilyState createState() => _ProfileFamilyState();
}

class _ProfileFamilyState extends State<ProfileFamily>
    with SingleTickerProviderStateMixin {

  List<Widget> _ScreensTab = [
    ProfileScreen(family: true,),
    Administration(header: false,),
  ];
  int _selectedIndex = 0;
  late TabController _tabController;

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
  getProfileGetx controller = Get.put(getProfileGetx());
  getFamilyPolicyGetx controller2 = Get.put(getFamilyPolicyGetx());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBar_taps(context, tabController: _tabController,
        selectedIndexx: _selectedIndex = 0,
        tap1: AppLocalizations
            .of(context)!
            .myprofile,
        tap2: AppLocalizations
            .of(context)!
            .administration,
        tap3: AppLocalizations
            .of(context)!
            .currentt,
        tap4: AppLocalizations
            .of(context)!
            .end,
      )
     ,
      body: TabBarView(
        controller: _tabController,
        children: [
          ProfileScreen(family: true,),
          Administration(),
        ],
      ),
    );
  }
// _OrderScreenState setContext(BuildContext context){
//   this.context=context;
//   return this;
// }
}