import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:url_launcher/url_launcher.dart';

final Color kSecondaryColor = kSpecialColor;

const Color kGrey = Color(0xff969696);

// rgb(175, 102, 119) #af6677    color app
const Color kBackgroundColor = Color(0xfffafafa);
const Color kTextColor = Color(0xff646464);
final Color kSpecialColor = const Color(0xffb25068).withOpacity(.9);

final Color kConfirm = Colors.green.shade400;
final Color kRefuse = Colors.red.shade400.withOpacity(.7);
//vvvvLarge
final double fLargevv = SizeConfig.scaleTextFont(38);

//titles // focus
double fLargev = SizeConfig.scaleTextFont(30);

//tabs navigation  chip
final double fLarge = SizeConfig.scaleTextFont(22);
final double fSmall = SizeConfig.scaleTextFont(21);
final double fSmallv = SizeConfig.scaleWidth(19);

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
Divider dividerApp({
  double height = 20,
  double thickness = 0,
}) {
  return Divider(
    thickness: SizeConfig.scaleHeight(thickness),
    height: SizeConfig.scaleHeight(height),
    color: kGrey.withOpacity(.3),
    indent: SizeConfig.scaleWidth(5),
    endIndent: SizeConfig.scaleWidth(5),
  );
}

class Notes extends StatelessWidget {
  final double width = double.infinity;
  final String note;
  const Notes({width = 360, this.note = ""});
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
          color: kSpecialColor.withOpacity(.3),
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: StyleText(
        note,
        maxLines: 200,
      ),
    );
  }
}

class ImageCircle extends StatelessWidget {
  final double size;
  final double radius;
  final String imageString;

  const ImageCircle({this.imageString = '', this.size = 0, this.radius = 43});
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: CachedNetworkImage(
        key: UniqueKey(),
        imageBuilder:
            (BuildContext context, ImageProvider<Object> imageProvider) =>
                CircleAvatar(
          backgroundImage: imageString != null || imageString.isNotEmpty
              ? CachedNetworkImageProvider(imageString)
              : null,
          radius: SizeConfig.scaleHeight(radius),

          // minRadius: SizeConfig.scaleHeight(radius),
        ),
        imageUrl: imageString,
        fadeInCurve: Curves.easeIn,
        fadeInDuration: const Duration(microseconds: 1),
        filterQuality: FilterQuality.low,
        maxHeightDiskCache: 50,
        maxWidthDiskCache: 50,
        memCacheWidth: 1,
        memCacheHeight: 1,
        fit: BoxFit.cover,

// alignment: Alignment.,
        color: Colors.transparent,
        fadeOutCurve: Curves.bounceInOut,

        placeholder: (BuildContext context, String url) => FittedBox(
          fit: BoxFit.scaleDown,
          child: CircleAvatar(
            radius: SizeConfig.scaleHeight(radius),
            backgroundImage: const AssetImage('assets/images/cover.jpeg'),
            backgroundColor: Colors.transparent,
          ),
        ),

        errorWidget: (BuildContext context, String url, error) {
          return FittedBox(
            fit: BoxFit.scaleDown,
            child: CircleAvatar(
              radius: SizeConfig.scaleHeight(radius),
              backgroundImage: const AssetImage('assets/images/cover.jpeg'),
              backgroundColor: Colors.transparent,
            ),
          );
        },
        // maxHeightDiskCache: 75,
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  final double radius;
  final double width;
  final double height;
  final String imageString;

  const ImageContainer(
    this.imageString, {
    this.radius = 45,
    this.width = double.infinity,
    this.height = 100,
  });
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: UniqueKey(),
      imageUrl: imageString,
      fadeInCurve: Curves.easeIn,
      width: SizeConfig.scaleWidth(width),
      height: SizeConfig.scaleHeight(height),
      fadeInDuration: const Duration(microseconds: 1),
      filterQuality: FilterQuality.high,
      maxHeightDiskCache: 600,
      maxWidthDiskCache: 600,
// color: Colors.transparent,
      fit: BoxFit.fill,
      placeholder: (BuildContext context, String url) => Image.asset(
        'assets/images/cover.jpeg',
        fit: BoxFit.fill,
        cacheHeight: 1,
        color: Colors.transparent,
        cacheWidth: 1,
        width: SizeConfig.scaleWidth(width),
        height: SizeConfig.scaleHeight(height),
      ),
      errorWidget: (BuildContext context, String url, error) {
        return Image.asset(
          'assets/images/cover.jpeg',
          fit: BoxFit.fill,
          cacheHeight: 1,
          cacheWidth: 1,
          width: SizeConfig.scaleWidth(width),
          height: SizeConfig.scaleHeight(height),
          color: Colors.transparent,
        );
      },
    );
  }
}

Center noContent(
  BuildContext context,
  String title, {
  IconData icon = Icons.warning_amber_outlined,
  double height = 320,
}) {
  return Center(
    child: Column(
      children: [
        SizedBox(
          height: SizeConfig.scaleHeight(height),
        ),
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber_outlined,
                color: kSpecialColor,
              ),
              StyleText(
                title,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class DividerNourah extends StatelessWidget {
  const DividerNourah({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.scaleHeight(15),
      child: VerticalDivider(
        color: kGrey.withOpacity(.5),
        width: 0,
      ),
    );
  }
}

SizedBox indicatorNourahLoading() {
  return SizedBox(
    height: 50,
    width: 50,
    child: CircularProgressIndicator.adaptive(
      // axisDirection: AxisDirection.down,
      // color: kSpecialColor,
      backgroundColor: kSpecialColor,
    ),
  );
}

SizedBox indicatorNourahLoadingSpecial() {
  return SizedBox(
    height: 50,
    width: 50,
    child: GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: kSpecialColor,
      child: CircularProgressIndicator.adaptive(
        strokeWidth: 5,
        // color: kSpecialColor,
        valueColor: AlwaysStoppedAnimation(kSpecialColor),
        backgroundColor: kSpecialColor.withOpacity(.5),
      ),
    ),
  );
}

Center indicatorNourahDone() {
  return Center(
    child: Stack(
      fit: StackFit.expand,
      children: [
        SizedBox(
          height: SizeConfig.scaleHeight(100),
          width: SizeConfig.scaleWidth(100),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: kSpecialColor.withOpacity(.8),
              value: 1,
            ),
          ),
        ),
        Icon(
          Icons.done,
          color: kSpecialColor,
          size: SizeConfig.scaleTextFont(35),
        )
      ],
    ),
  );
}

void launchURL(url) async => await canLaunchUrl(Uri.parse(url))
    ? await launchUrl(Uri.parse(url))
    : throw 'Could not launch $url';
