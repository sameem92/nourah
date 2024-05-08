import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/components/containers/card_app.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

class CardNewDelivery extends StatefulWidget {
  final String driverName;
  final dynamic driverRate;
  final int? driverTime;
  final String? driverTimeUnit;
  final String? driverCost;
  final int? id;
  final String driverImage;
  final Function onPressed;
  CardNewDelivery(
      {required this.onPressed,
      this.id = 0,
      this.driverTime = 0,
      this.driverName = "",
      this.driverRate = 0,
      this.driverImage = "",
      this.driverCost = "",
      this.driverTimeUnit = ""});
  @override
  _CardNewDeliveryState createState() => _CardNewDeliveryState();
}

class _CardNewDeliveryState extends State<CardNewDelivery> {
  @override
  Widget build(BuildContext context) {
    return cardApp(
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: SizeConfig.scaleWidth(250),
              child: Row(
                children: [
                  Expanded(
                    flex: 11,
                    child: StyleText(
                      widget.driverName,
                      textColor: kSpecialColor,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        StyleText(
                          "${widget.driverRate}",
                          textAlign: TextAlign.end,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: fIconSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: hSpace,
            ),
            SizedBox(
              width: SizeConfig.scaleWidth(250),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: StyleText(
                      "${widget.driverTime}  ${widget.driverTimeUnit == "h" ? AppLocalizations.of(context)!.hour : widget.driverTimeUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: StyleText(
                      "${widget.driverCost} ${AppLocalizations.of(context)!.reyal}",
                      textColor: kSpecialColor,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: hSpace,
            ),
            SizedBox(
              width: SizeConfig.scaleWidth(150),
              child: StyleButton(
                AppLocalizations.of(context)!.acceptdeal,
                onPressed: () {
                  widget.onPressed();
                  // await confirmDeliveryOrder(id:id);
                },
              ),
            )
          ],
        ),
      ),
      special: true,
      image: widget.driverImage,
    );
  }
}
