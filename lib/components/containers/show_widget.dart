import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

class ShowFamilyWidget extends StatelessWidget {
  final String productName;
  final String familyName;
  final String familyLocation;
  final String price;
  final String categoriesArName;
  final String categoriesEnName;
  final String priceBefore;
  final String discount;
  final String time;
  final String rate;
  final int productId;
  final int state;
  final int categoriesCount;
  final String timer;
  final String familyCat;
  final bool family;
  final bool familyProfile;
  final bool discountBool;
  final String image;
  final Widget categories;

  ShowFamilyWidget(
    this.categories, {
    this.productName = '',
    this.familyName = '',
    this.familyLocation = '',
    this.price = '',
    this.priceBefore = '',
    this.discount = '',
    this.time = '',
    this.rate = '',
    this.state = 0,
    this.discountBool = false,
    this.categoriesCount = 0,
    this.timer = '',
    this.familyCat = '',
    this.image = "",
    this.productId = 0,
    this.categoriesArName = "",
    this.categoriesEnName = "",
    this.family = false,
    this.familyProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.scaleWidth(350),
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: kGrey.withOpacity(.1), blurRadius: 2, spreadRadius: 1),
        ],
        backgroundBlendMode: BlendMode.luminosity,
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.white,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 28,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
                child: ImageContainer(
                  image,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(
              height: hSpaceSmall,
            ),
            Expanded(
              flex: 12,
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: wCard,
                  end: wCard,
                  top: hCard,
                  bottom: hCard,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    familyProfile == true
                        ? const SizedBox(
                            height: 10,
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    Expanded(
                      child: SizedBox(
                        width: wShow,
                        child: Stack(
                          children: [
                            StyleText(
                              familyName,
                              textAlign: TextAlign.center,
                              textColor: kSpecialColor,
                              width: wShow,
                              maxLines: 2,
                              fontWeight: FontWeight.w500,
                            ),
                            if (family != true)
                              SizedBox(
                                width: wShow,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: StyleText(
                                        time,
                                        maxLines: 2,
                                      ),
                                    ),
                                    const DividerNourah(),
                                    discountBool == true
                                        ? Expanded(
                                            flex: 2,
                                            child: StyleText(
                                              discount,
                                              maxLines: 2,
                                            ),
                                          )
                                        : Row(),
                                    discountBool == true
                                        ? const DividerNourah()
                                        : Row(),
                                    discountBool == true
                                        ? Expanded(
                                            flex: 1,
                                            child: StyleText(
                                              priceBefore,
                                              maxLines: 2,
                                              fontSize: 18,
                                              textDecoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          )
                                        : Row(),
                                    if (discountBool == true)
                                      const DividerNourah()
                                    else
                                      Row(),
                                    Expanded(
                                      flex: 3,
                                      child: StyleText(
                                        "${price}",
                                        maxLines: 2,
                                        textColor: kSpecialColor,
                                        // fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    if (family == true) categories,
                    if (family != true)
                      Expanded(
                        child: SizedBox(
                          width: wShow,
                          child: Stack(
                            children: [
                              StyleText(
                                productName,
                                width: wShow,
                                textColor: kSpecialColor,
                                // fontWeight: FontWeight.w700,
                                textAlign: TextAlign.center,
                              ),
                              StyleText(
                                familyCat,
                                textAlign: TextAlign.center,
                                width: wShow,
                                maxLines: 2,
                                textColor: kSpecialColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (familyProfile == false)
                      Expanded(
                        child: SizedBox(
                          width: wShow,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: kTextColor,
                                    size: fIconSmall,
                                  ),
                                  StyleText(
                                    familyLocation,
                                    textAlign: TextAlign.start,
                                    height: 1.5,
                                  ),
                                ],
                              ),
                              const DividerNourah(),
                              Stack(
                                children: [
                                  state == 1
                                      ? StyleText(
                                          AppLocalizations.of(context)!
                                              .available,
                                          textColor: kConfirm,
                                        )
                                      : state == 0
                                          ? StyleText(
                                              AppLocalizations.of(context)!
                                                  .unavailable,
                                              textColor: kRefuse,
                                            )
                                          : const StyleText(""),
                                  StyleText(
                                    timer,
                                    textColor: Colors.green,
                                    // width: SizeConfig.scaleWidth(180),
                                  ),
                                ],
                              ),
                              const DividerNourah(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: fIconSmall,
                                  ),
                                  StyleText(
                                    rate,
                                    textAlign: TextAlign.start,
                                    height: 1.5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
