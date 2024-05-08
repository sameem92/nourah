import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/components/containers/card_app.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

class CardWidget extends StatelessWidget {
  final String productName;
  final String familyName;
  final String familyLocation;
  final String price;
  final String priceBefore;
  final String discount;
  final String time;
  final String categoriesArName;
  final String categoriesEnName;
  final bool family;
  final bool familyProfile;
  final bool familyScreens;
  final bool discountBoolCard;
  final String rate;
  final int state;
  final int categoriesCount;
  final String timer;
  final String familyCat;
  final String page;
  final String image;
  final String offer;
  final Widget categories;

  const CardWidget(
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
    this.categoriesCount = 0,
    this.timer = '',
    this.familyCat = '',
    this.page = '',
    this.image = '',
    this.offer = '',
    this.categoriesArName = "",
    this.categoriesEnName = "",
    this.family = false,
    this.familyProfile = false,
    this.familyScreens = false,
    this.discountBoolCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return cardApp(
      Row(
        children: [
          SizedBox(

            width: SizeConfig.scaleWidth(405),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                  Stack(
                    children: [
                      StyleText(
                        familyName,
                        textColor: kSpecialColor,
                        textAlign: TextAlign.start,
                        width: wBetweenCard,
                        maxLines: 2,
                        fontWeight: FontWeight.w500,
                      ),
                      if (family != true)

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Spacer(),
                              Expanded(
                                flex: 7,
                                child: StyleText(
                                  time,
                                  maxLines: 2,
                                ),
                              ),
                              discountBoolCard == true
                                  ? const DividerNourah()
                                  : Row(),
                              discountBoolCard == true
                                  ? Expanded(
                                      flex: 4,
                                      child: StyleText(
                                        discount,
                                        maxLines: 2,
                                      ),
                                    )
                                  : Row(),
                              discountBoolCard == true
                                  ? const DividerNourah()
                                  : Row(),
                              discountBoolCard == true
                                  ? Expanded(
                                      flex: 4,
                                      child: StyleText(
                                        priceBefore,
                                        maxLines: 2,
                                        textDecoration:
                                            TextDecoration.lineThrough,
                                      ),
                                    )
                                  : Row(),
                              const DividerNourah(),
                              Expanded(
                                flex: 5,
                                child: StyleText(
                                  price,
                                  maxLines: 2,
                                  textColor: kSpecialColor,
                                  // fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),

                    ],
                  ),
                // SizedBox(
                //   height: hSpaceSmall,
                // ),



                familyProfile == true
                    ? SizedBox(
                        height: hSpace,
                      )
                    : const SizedBox(),
                if (family == true) categories,
                if (family != true)




                    Stack(
                      children: [
                        StyleText(
                          productName,
                          // width: SizeConfig.scaleWidth(314),
                          textColor: kSpecialColor,
                          height: SizeConfig.scaleHeight(1.4),
                          // fontWeight: FontWeight.w700,
                        ),
                        StyleText(
                          familyCat,
                          // width: SizeConfig.scaleWidth(314),
                          textColor: kSpecialColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),



                // SizedBox(
                //   height: hSpaceSmall,
                // ),
                familyProfile == false
                    ?
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (familyLocation != '')
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: kTextColor,
                                    size: fIconSmall,
                                  ),
                                  StyleText(
                                    familyLocation,
                                    textAlign: TextAlign.start,
                                    height: 1.2,
                                  ),
                                ],
                              ),
                            if (familyScreens != true) const DividerNourah(),
                            if (state != '')
                              Stack(
                                children: [
                                  state == 1
                                      ? StyleText(
                                          AppLocalizations.of(context)!.available,
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
                                  ),
                                ],
                              ),
                            if (familyScreens != true) const DividerNourah(),
                            if (rate != '')
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                    height: 1.2,
                                  ),
                                ],
                              ),
                            if (offer != '')
                              StyleText(
                                offer,
                                textColor: kConfirm,
                                textAlign: TextAlign.start,
                              ),
                          ],
                        )

                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
      image: image,
    );
  }
}
