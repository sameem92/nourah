import 'package:flutter/material.dart';
import 'package:producer_family_app/components/containers/card_app.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  CardWidget(
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
    this.familyScreens = false,
    this.discountBoolCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return card_app(
      Row(
        children: [

          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: wBetweenCard,
                  child: Stack(
                    children: [
                      StyleText(
                        familyName,
                        textColor: kSpecialColor,
                        textAlign: TextAlign.start,
                        width: wBetweenCard,
                        // fontWeight: FontWeight.w700,
                      ),
                      if (family != true)
                      SizedBox(
                        width: wBetweenCard,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Spacer(),
                            Expanded(
                              flex: 4,
                              child: StyleText(
                                time,
                              ),
                            ),
                            discountBoolCard==true?
                            dividerNourah():Row(),
                            discountBoolCard==true?
                            Expanded(
                              flex: 2,
                              child: StyleText(
                                discount,
                              ),
                            ):Row(),
                            discountBoolCard==true? dividerNourah():Row(),
                            discountBoolCard==true?   Expanded(
                              flex: 2,
                              child: StyleText(
                                priceBefore,
                                textDecoration: TextDecoration.lineThrough,
                              ),
                            ):Row(),
                            dividerNourah(),
                            Expanded(
                              flex: 3,
                              child: StyleText(
                                price,
                                textColor: kSpecialColor,
                                // fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: hSpaceSmall,
                ),
                if (family == true) categories,
                if (family != true)
                  SizedBox(
                    width: SizeConfig.scaleWidth(314),
                    child: Stack(
                      children: [
                        StyleText(
                          productName,
                          width: SizeConfig.scaleWidth(314),
                          textColor: kSpecialColor,
                          // fontWeight: FontWeight.w700,
                        ),
                        StyleText(
                          familyCat,
                          width: SizeConfig.scaleWidth(314),
                          textColor: kSpecialColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: hSpaceSmall,
                ),
                SizedBox(
                  width: wBetweenCard,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (familyLocation != '' && familyLocation != null)
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: kSecondaryColor,
                              size: fIconSmall,
                            ),
                            StyleText(
                              "$familyLocation",
                              textAlign: TextAlign.start,
                              height: 1.5,
                            ),
                          ],
                        ),
                      if(familyScreens!=true)
                      dividerNourah(),
                      if (state != '' && state != null)
                        Stack(
                          children: [
                            state == 1
                                ? StyleText(
                                    AppLocalizations.of(context)!.available,
                                    textColor: kConfirm,
                                  )
                                : state == 0
                                    ? StyleText(
                                        AppLocalizations.of(context)!.unavailable,
                                        textColor: kRefuse,
                                      )
                                    : StyleText(""),
                            StyleText(
                              timer,
                              textColor: Colors.green,
                            ),
                          ],
                        ),
                      if(familyScreens!=true)

                        dividerNourah(),
                      if (rate != '' && rate != null)
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
                      if (offer != '' && offer != null)
                        StyleText(
                          offer,
                          textColor: kConfirm,
                          textAlign: TextAlign.start,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      image: image,
    );
  }
}
