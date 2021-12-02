import 'package:flutter/material.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

AppBar appBar_taps(BuildContext context,
    {required TabController tabController,
    required int selectedIndexx,
    required String tap1,
    required String tap2,
    required String tap3,
    String tap4 = "",
    bool tap4Exist = false,
    bool tap3Exist = false}) {
  return AppBar(
    toolbarHeight: SizeConfig.scaleHeight(20),
    automaticallyImplyLeading: false,
    centerTitle: true,
    backgroundColor: kBackgroundColor,
    elevation: SizeConfig.scaleHeight(1),
    bottom: TabBar(

      controller: tabController,
      onTap: (int selectedIndex) {
        selectedIndexx = 2;

      },
      labelColor: kSpecialColor,
      indicatorWeight: SizeConfig.scaleHeight(3.0),
      unselectedLabelColor: kTextColor,
      labelPadding: EdgeInsets.only(bottom: 0),
      indicatorColor: kSpecialColor,
      labelStyle: TextStyle(
        fontSize: fLarge,
        fontFamily: "ElMessiri",
      ),
      tabs: [
        Tab(
          text: tap1,
        ),
        Tab(
          text: tap2,
        ),
        if (tap3Exist == true)
          Tab(
            text: tap3,
          ),
        if (tap4Exist == true)
          Tab(
            text: tap4,
          ),
      ],
    ),
  );
}

class AppBarFamily extends PreferredSize {
  final Widget? bottom;
  final Widget? search;
  final Widget? botoom;
  AppBarFamily({this.bottom,this.search,this.botoom}) : super(child:StyleText("") ,preferredSize: Size.fromHeight(120),);

  @override
  Size get preferredSize => Size.fromHeight(
        SizeConfig.scaleWidth(105),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: wPadding,
          right: wPadding,
          top: hPadding,
          bottom: hPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             SizedBox(
               height: SizeConfig.scaleWidth(35),

               child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                        Expanded(flex: 9,child: search!),
                        SizedBox(
                          width: wSpaceSmall,
                        ),
                        Expanded(child: botoom!),
                    SizedBox(
                      width: wSpace,
                    ),
                  ],
                ),
             ),
            SizedBox(height: wSpace,),
            SizedBox(
              child: bottom,
              height: SizeConfig.scaleHeight(35),
            ),
            divider_app(height: 0,),
          ],
        ),
      ),
    );
  }
}
AppBar AppBarWhite(BuildContext context,
    {IconData? iconBack = Icons.arrow_back,bool main = false,
    String title = "",double elevation =1,
    required Function onPressed,bool back=false,
    IconData? icon}) {
  return AppBar(
    centerTitle: true,

    title: StyleText(
      title,
      textColor: kSecondaryColor,
      fontSize: SizeConfig.scaleWidth(30),
    ),
    elevation: elevation,
   leading:
   IconButton(
        onPressed: () {
          main==false
        ?  Navigator.pop(context)
          :Navigator.pushReplacementNamed(context, "/mainScreen");

        },
        icon: Icon(
          iconBack,
          color: kSecondaryColor,
          size: fIcon,
        )),
   // :Column(),

    actions: [
      IconButton(
        onPressed: () {
          onPressed();
        },
        icon: Icon(icon),
        color: kSecondaryColor,
      )
    ],
    backgroundColor: kBackgroundColor,
  );
}
