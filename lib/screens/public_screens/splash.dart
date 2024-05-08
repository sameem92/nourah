import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:path_provider/path_provider.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

import '../../storage/shared_preferences_controller.dart';
import 'map_screen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animationRotation;
  late Animation<double> animationRadiusIn;
  late Animation<double> animationRadiusOut;

  // Color _colorDot =Colors.grey.shade400;
  final Color _colorDot = Colors.white;
  final Color _colorDotSmall = Colors.white;

  static double initialRadius = SizeConfig.scaleHeight(100);
  static double radius = SizeConfig.scaleHeight(0.0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    managenotificationAction(context);
    Get.put(GetBannersGetx());

    Future.delayed(const Duration(milliseconds: 2900), () async {
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => PaymentScreen(
      //               // builder: (context) => mainApplePay(
      //               title: 'asasas',
      //             )));

      if (SharedPreferencesController().isLoggedInFamily == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MapScreen(
                      family: true,
                    )));
      } else if (SharedPreferencesController().isLoggedInDriver == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MapScreen(
                      driver: true,
                    )));
      } else if (SharedPreferencesController().isLoggedInUser == true) {
        String fileName4 = "getHome.json";
        var dir4 = await getTemporaryDirectory();
        File file4 = File("${dir4.path}/$fileName4");
        if (file4.existsSync()) file4.deleteSync(recursive: true);
        // print('getHome.json deleteSync user');

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MapScreen(
                      user: true,
                    )));
      } else {
        String fileName4 = "getHome.json";
        var dir4 = await getTemporaryDirectory();
        File file4 = File("${dir4.path}/$fileName4");
        if (file4.existsSync()) file4.deleteSync(recursive: true);
        // print('getHome.json deleteSync no user');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MapScreen(
                      user: false,
                    )));
      }
    });

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));

    animationRotation = Tween<double>(
      begin: 0,
      end: 1.1,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.1, 1, curve: Curves.linear)));

    animationRadiusIn = Tween<double>(
      begin: 1,
      end: 2,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(.8, 1, curve: Curves.easeInToLinear)));

    animationRadiusOut = Tween<double>(
      begin: 0.0,
      end: 1.15,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 1, curve: Curves.easeOutBack)));

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.80 && controller.value <= 2) {
          radius = animationRadiusIn.value * initialRadius;
        } else if (controller.value >= 0.0 && controller.value <= .9) {
          radius = animationRadiusOut.value * initialRadius;
        }
      });
    });
    controller.repeat(
      period: const Duration(milliseconds: 3000),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double dotRadius = SizeConfig.scaleTextFont(15.0);
    double dotRadiusSmall = SizeConfig.scaleTextFont(10.0);
    return Scaffold(
        backgroundColor: kSpecialColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Image.asset('assets/images/logopinknourah.png',filterQuality: FilterQuality.high,colorBlendMode: BlendMode.clear),
                CircleAvatar(
                  radius: SizeConfig.scaleHeight(90),
                  foregroundColor: Colors.transparent,
                  // foregroundImage: AssetImage('assets/images/logopinknourah.png'),
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/images/nourahlogowhite.png'),
                ),
                RotationTransition(
                  turns: animationRotation,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Transform.translate(
                          offset: Offset(radius * cos(2 * pi / 10),
                              radius * sin(2 * pi / 10)),
                          child: Dot(
                            radius: dotRadius,
                            color: _colorDot,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(3 * pi / 10),
                              radius * sin(3 * pi / 10)),
                          child: Dot(
                            radius: dotRadiusSmall,
                            color: _colorDotSmall,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(4 * pi / 10),
                              radius * sin(4 * pi / 10)),
                          child: Dot(
                            radius: dotRadius,
                            color: _colorDot,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(5 * pi / 10),
                              radius * sin(5 * pi / 10)),
                          child: Dot(
                            radius: dotRadiusSmall,
                            color: _colorDotSmall,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(6 * pi / 10),
                              radius * sin(6 * pi / 10)),
                          child: Dot(
                            radius: dotRadius,
                            color: _colorDot,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(7 * pi / 10),
                              radius * sin(7 * pi / 10)),
                          child: Dot(
                            radius: dotRadiusSmall,
                            color: _colorDotSmall,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(8 * pi / 10),
                              radius * sin(8 * pi / 10)),
                          child: Dot(
                            radius: dotRadius,
                            color: _colorDot,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(9 * pi / 10),
                              radius * sin(9 * pi / 10)),
                          child: Dot(
                            radius: dotRadiusSmall,
                            color: _colorDotSmall,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(10 * pi / 10),
                              radius * sin(10 * pi / 10)),
                          child: Dot(
                            radius: dotRadius,
                            color: _colorDot,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(11 * pi / 10),
                              radius * sin(11 * pi / 10)),
                          child: Dot(
                            radius: dotRadiusSmall,
                            color: _colorDotSmall,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(12 * pi / 10),
                              radius * sin(12 * pi / 10)),
                          child: Dot(
                            radius: dotRadius,
                            color: _colorDot,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(13 * pi / 10),
                              radius * sin(13 * pi / 10)),
                          child: Dot(
                            radius: dotRadiusSmall,
                            color: _colorDotSmall,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(14 * pi / 10),
                              radius * sin(14 * pi / 10)),
                          child: Dot(
                            radius: dotRadius,
                            color: _colorDot,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(15 * pi / 10),
                              radius * sin(15 * pi / 10)),
                          child: Dot(
                            radius: dotRadiusSmall,
                            color: _colorDotSmall,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(16 * pi / 10),
                              radius * sin(16 * pi / 10)),
                          child: Dot(
                            radius: dotRadius,
                            color: _colorDot,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(17 * pi / 10),
                              radius * sin(17 * pi / 10)),
                          child: Dot(
                            radius: dotRadiusSmall,
                            color: _colorDotSmall,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(18 * pi / 10),
                              radius * sin(18 * pi / 10)),
                          child: Dot(
                            radius: dotRadius,
                            color: _colorDot,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(19 * pi / 10),
                              radius * sin(19 * pi / 10)),
                          child: Dot(
                            radius: dotRadiusSmall,
                            color: _colorDotSmall,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(20 * pi / 10),
                              radius * sin(20 * pi / 10)),
                          child: Dot(
                            radius: dotRadius,
                            color: _colorDot,
                          )),
                      Transform.translate(
                          offset: Offset(radius * cos(21 * pi / 10),
                              radius * sin(21 * pi / 10)),
                          child: Dot(
                            radius: dotRadiusSmall,
                            color: _colorDotSmall,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(130),
            ),
            StyleText(
              AppLocalizations.of(context)!.name,
              textColor: Colors.white,
              fontSize: SizeConfig.scaleWidth(35),
            ),
            SizedBox(
              height: hSpaceLargev,
            ),
            StyleText(
              AppLocalizations.of(context)!.hello,
              textColor: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig.scaleWidth(30),
            ),
          ],
        ));
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({required this.radius, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
