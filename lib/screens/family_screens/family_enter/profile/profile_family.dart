import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/screens/public_screens/profile_screen.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/family_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/storage/providersAndGetx/login_profile_getx.dart';
import 'package:provider/provider.dart';

import '../../../public_screens/administration.dart';

class ProfileFamily extends StatefulWidget {
  final int profileIndex;
  const ProfileFamily({
    this.profileIndex = 0,
  });
  @override
  _ProfileFamilyState createState() => _ProfileFamilyState();
}

class _ProfileFamilyState extends State<ProfileFamily>
    with SingleTickerProviderStateMixin {
  List<Widget> screensTab = [
    const ProfileScreen(
      family: true,
    ),
    const Administration(
      header: false,
    ),
  ];
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    managenotificationAction(context);

    _tabController = TabController(length: screensTab.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
        Provider.of<intIndexProfile>(context, listen: false)
            .changeIntIndexProfile(_tabController.index);
      });
    });
    _tabController.animateTo(
        Provider.of<intIndexProfile>(context, listen: false).intIndex != null
            ? Provider.of<intIndexProfile>(context, listen: false).intIndex!
            : 0);
  }

  getProfileGetx controller = Get.find();
  GetFamilyPolicyGetx controller2 = Get.put(GetFamilyPolicyGetx());
  @override
  void dispose() {
    _tabController.dispose();

    Get.delete<GetFamilyPolicyGetx>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTaps(
        context,
        tabController: _tabController,
        selectedIndexx: _selectedIndex,
        tap1: AppLocalizations.of(context)!.myprofile,
        tap2: AppLocalizations.of(context)!.administration,
        tap3: AppLocalizations.of(context)!.currentt,
        tap4: AppLocalizations.of(context)!.end,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const ProfileScreen(
            family: true,
          ),
          const Administration(),
        ],
      ),
    );
  }
}
