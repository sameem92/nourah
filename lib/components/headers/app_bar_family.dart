import 'package:flutter/material.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:provider/provider.dart';

AppBar appBarTaps(BuildContext context,
    {required TabController tabController,
      required int selectedIndexx,
      required String tap1,
      required String tap2,
      required String tap3,
      String tap4 = "",
      bool tap4Exist = false,
      bool tap3Exist = false,}) {
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
        Provider.of<intIndexorder>(context, listen: false)
            .changeIntIndexorder(selectedIndex);
      },
      labelColor: kSpecialColor,
      indicatorWeight: SizeConfig.scaleHeight(3.0),
      unselectedLabelColor: kTextColor,
      labelPadding: const EdgeInsets.only(bottom: 0),
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
  AppBarFamily({this.bottom,this.search,this.botoom}) : super(child:const StyleText("") ,preferredSize: const Size.fromHeight(120),);

  @override
  Size get preferredSize => Size.fromHeight(
    SizeConfig.scaleTextFont(120),
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
            Expanded(
              child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 9,child: search!),

                    Expanded(child: botoom!),

                  ],
                ),
              ),
SizedBox(height: hSpace,),
            Expanded(

              child: SizedBox(
                child: bottom,
              ),
            ),

            dividerApp(height: 0,),
          ],
        ),
      ),
    );
  }
}
AppBar appBarWhite(BuildContext context,
    {IconData? iconBack = Icons.arrow_back,bool main = false,
      String title = "",double elevation =1,bool backOk=true,
      required Function onPressed,bool back=false,Function? onPressedBack,bool onPressedBackBool =false
      ,  IconData? icon,}) {
  return AppBar(
    centerTitle: true,

    title: StyleText(
      title,
      textColor: kBackgroundColor,
      fontSize: SizeConfig.scaleWidth(30),
    ),
    elevation: elevation,
    leading:
    IconButton(
        onPressed: () {
          main==false
              ?  Navigator.pop(context)
              : backOk==true ?Navigator.pushReplacementNamed(context, "/mainScreen"):null;
          if(onPressedBackBool)  onPressedBack!();
        },
        icon: Icon(
          onPressedBackBool ==false ?iconBack:Icons.close,
          color: kBackgroundColor,
          size: fIcon,
        ),),
    // :Column(),

    actions: [
      IconButton(
        onPressed: () {
          onPressed();
        },
        icon: Icon(icon),
        color: kBackgroundColor,
      )
    ],
    backgroundColor: kSpecialColor,
  );
}
