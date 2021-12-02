
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const kPrimaryColor = Color(0xFF8B8D7E);
final kSecondaryColor = Color(0xFF87695C).withOpacity(.8);
const kSecondaryColorButtom = Color(0xFF87695C);
// const kSecondaryColor = Color(0xFF785B4E);
// const kSecondaryColor = Color(0xff837672);
// const kSecondaryColor = Color(0xD0423434);
// const kSecondaryColor = Color(0xFF6F615D);
// const kBackgroundColor = Color(0xFFefefef);
const kBackgroundColor = Color(0xfffafafa);
// const kTextColor =Color(0xFF785B4E);
const kTextColor = Color(0xFF6F615D);
// const kSpecialColor =Color(0xFFF57C00);
// final kSpecialColor =Colors.orange.shade600;
final kSpecialColor = Color(0xFFE39B36).withOpacity(1);
final k2Color = Color(0xFF9D9F8D);
// final kSpecialColor =Color(0xFFDE9C4D);
final kConfirm = Colors.green.shade400.withOpacity(.9);
final kRefuse = Colors.red.shade400.withOpacity(.9);
// const kSpecialColor =Colors.;

//vvvvLarge
final double fLargevv = SizeConfig.scaleTextFont(38);

//titles // focus
 double fLargev = SizeConfig.scaleTextFont(30);

//tabs navigation  chip
final double fLarge = SizeConfig.scaleTextFont(20);
final double fSmall = SizeConfig.scaleTextFont(19);
final double fSmallv = SizeConfig.scaleWidth(17);

//Icon
final double fIcon = SizeConfig.scaleTextFont(25);
final double fIconLarge = SizeConfig.scaleTextFont(28);
final double fIconSmall = SizeConfig.scaleTextFont(18);

//card  container
final double wCard = SizeConfig.scaleWidth(2);
final double hCard = SizeConfig.scaleWidth(5);

//show
final double wShow = SizeConfig.scaleWidth(366);
final double borderRadius = SizeConfig.scaleWidth(20);
final double borderWidth = SizeConfig.scaleWidth(0);
final double hCardMar = SizeConfig.scaleWidth(5);
final double wCardMar = SizeConfig.scaleWidth(2);
final double wBetweenCard = SizeConfig.scaleWidth(290);
final double wAllCard = SizeConfig.scaleWidth(404);

//screen
final double wPadding = SizeConfig.scaleWidth(8);
final double hPadding = SizeConfig.scaleWidth(10);

//SizedBox spaces,,,
final double hSpace = SizeConfig.scaleHeight(12);
final double hSpaceLarge = SizeConfig.scaleHeight(20);
final double hSpaceLargev = SizeConfig.scaleHeight(30);
final double hSpaceLargevv = SizeConfig.scaleHeight(50);
final double wSpace = SizeConfig.scaleWidth(12);
final double wSpaceLarge = SizeConfig.scaleWidth(30);
final double wSpaceLargev = SizeConfig.scaleWidth(50);
final double hSpaceSmall = SizeConfig.scaleHeight(5);
final double wSpaceSmall = SizeConfig.scaleWidth(5);



//height header
final double hheader = SizeConfig.scaleHeight(40);

//
Divider divider_app({
  double height = 20,
  double thickness = 0,
}) {
  return Divider(
    thickness: SizeConfig.scaleHeight(thickness),
    height: SizeConfig.scaleHeight(height),
    color: kSecondaryColor.withOpacity(.4),
    indent: SizeConfig.scaleWidth(5),
    endIndent: SizeConfig.scaleWidth(5),
  );
}

class notes extends StatelessWidget {
  final double width = double.infinity;
  String note;
  notes({width=360, this.note=""});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.scaleWidth(350),
      padding: EdgeInsets.only(
        left: wPadding,
        right: wPadding,
        top: hSpaceLargev,
        bottom: hSpaceLargev,
      ),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border.all(
            color: kSecondaryColor.withOpacity(0),
            width: borderWidth,
          ),
          borderRadius:
              BorderRadius.circular(borderRadius)),
      child: StyleText(
        note,
        maxLines: 20,
      ),
    );
  }
}

class image_circle extends StatelessWidget {
  double size;
  double radius;
  String imageString;

  image_circle({this.imageString='',this.size = 0, this.radius = 45});
  @override
  Widget build(BuildContext context) {
    return

    CachedNetworkImage(
          imageBuilder: (context, imageProvider) => CircleAvatar(
            backgroundImage:imageString != null || imageString.isNotEmpty?
            CachedNetworkImageProvider(imageString):
            null,
            // foregroundImage: CachedNetworkImageProvider(imageString),

            radius: SizeConfig.scaleTextFont(radius),
          ),
          imageUrl: imageString,
          fadeInCurve: Curves.bounceInOut,
          fit: BoxFit.fill,
color: Colors.transparent,
          filterQuality: FilterQuality.high,
colorBlendMode: BlendMode.clear,
          fadeOutCurve: Curves.bounceInOut,

          placeholder: (context, url) => CircleAvatar(
            radius: SizeConfig.scaleTextFont(radius),
            backgroundImage: AssetImage('assets/images/cover.jpeg'),
            backgroundColor: Colors.transparent,

          ),

          errorWidget: (context, url, error) {
            return CircleAvatar(
              radius: SizeConfig.scaleTextFont(radius),
              backgroundImage: AssetImage('assets/images/cover.jpeg'),

            );
          },
          maxHeightDiskCache: 75,
        // ),
      // ),
    );
  }
}

class image_container extends StatelessWidget {

  double radius;
  double width;
  double height;
  String imageString;

  image_container(this.imageString,
      {
      this.radius = 45,
      this.width = double.infinity,
      this.height = 100});
  @override
  Widget build(BuildContext context) {
    return

        CachedNetworkImage(
          imageUrl: imageString ,
          fadeInCurve: Curves.bounceInOut,
          width: SizeConfig.scaleWidth(width),
          height:SizeConfig.scaleHeight(height),

          fit: BoxFit.fill,
          placeholder: (context, url) => Image.asset(
            'assets/images/cover.jpeg',
            fit: BoxFit.cover,
            width: SizeConfig.scaleWidth(width),
            height:SizeConfig.scaleHeight(height),
          ),
          errorWidget: (context, url, error) {
           return Image.asset(
              'assets/images/cover.jpeg',
              fit: BoxFit.cover,
             width: SizeConfig.scaleWidth(width),
             height:SizeConfig.scaleHeight(height),
            );

          },

          maxHeightDiskCache: 75,

    );
  }
}

Center noContent(BuildContext context,String title, {IconData icon :Icons.warning_amber_outlined,double height=320 }) {
  return Center(
    child: Column(
      children: [
        SizedBox(height: SizeConfig.scaleHeight(height),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CircularProgressIndicator(),
            Icon(Icons.warning_amber_outlined,color: kSecondaryColor,),
            StyleText(title,maxLines: 2,),

          ],
        ),
      ],
    ),
  );
}
class dividerNourah extends StatelessWidget {
  const dividerNourah({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    
        SizedBox(height: SizeConfig.scaleHeight(15),child: VerticalDivider(color: kSecondaryColor.withOpacity(.4),width: 0,));
      // StyleText("|",fontSize: SizeConfig.scaleWidth(20),textColor: kSecondaryColor.withOpacity(.5),);
  }
}

//
//
// "${controller.products[index].durationUnit == "h"
// ? AppLocalizations.of(context)!.hour
//     :"${controller.products[index].durationUnit}" =="m"
// ? AppLocalizations.of(context)!.minute
//     : AppLocalizations.of(context)!.day} "

//
//
// time:
// "${controller.products[index].durationTo}-${controller.products[index].durationFrom} "
// "${controller.products[index].durationUnit == "h"
// ? AppLocalizations.of(context)!.hour
//     :"${controller.products[index].durationUnit}" =="m"
// ? AppLocalizations.of(context)!.minute
//     : AppLocalizations.of(context)!.day} ",

SizedBox indicator_nourah_loading() {
  return SizedBox(
      height: 50,
      width: 50,
      child:
      CircularProgressIndicator(
        strokeWidth: 7,
        color: kSpecialColor,
        valueColor:
        AlwaysStoppedAnimation(
            kSecondaryColor),
        backgroundColor: kSecondaryColor
            .withOpacity(.5),
      )
  );
}

Center indicator_nourah_done() {
  return Center(
    child: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            height: SizeConfig.scaleHeight(100),
            width: SizeConfig.scaleWidth(100),
            child: Center(
              child:
              CircularProgressIndicator(
                strokeWidth: 3,
                color: kSpecialColor
                    .withOpacity(.8),
                value: 1,
              ),
            ),
          ),
          Icon(
            Icons.done,
            color: kSpecialColor,
            size: SizeConfig
                .scaleTextFont(35),
          )
        ]),
  );
}