import 'package:flutter/material.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'container_app.dart';

class card_cart extends StatefulWidget {
  String image="";String productName="";int productQu=0;bool confirm=false
  ;int productPrice;int price;
  card_cart({this.confirm=false,this.image='',this.price=0, this.productName='', this.productQu=0, this.productPrice=0});
  @override
  _card_cartState createState() => _card_cartState();
}
class _card_cartState extends State<card_cart> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(
        left: wCard,
        right: wCard,
        top: hCard,
        bottom: hSpaceLarge,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image_circle(imageString: widget.image,
              size: SizeConfig.scaleTextFont(90)),
          SizedBox(width: wSpaceSmall,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: SizeConfig.scaleWidth(265),
                child: Row(
                  children: [
                    Expanded(
                      flex: 13,
                      child: StyleText(
                        widget.productName,
                        textAlign: TextAlign.start,
                        textColor: kSpecialColor,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: StyleText(
                        "${widget.productQu* widget.price}  ${AppLocalizations.of(context)!.reyal}",
                        textAlign: TextAlign.end,
                        textColor: kSpecialColor,
                        // width: SizeConfig.scaleWidth(67),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: hSpace,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.confirm==false
                ?  SizedBox(
                    child: SizedBox(
                      width: SizeConfig.scaleWidth(150),
                      height: SizeConfig.scaleHeight(50),
                      child: ContainerApp(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: kSpecialColor.withOpacity(.9),
                                  size: fIcon,
                                ),
                                disabledColor: kSecondaryColor,
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    if (widget.productQu != 0) {
                                      widget.productQu -= 1;
                                    }
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: StyleText(
                                "${widget.productQu}",
                                textColor: kSpecialColor,
                                height: 1.5,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(
                                  Icons.add_circle_outlined,
                                  color: kSpecialColor.withOpacity(.9),
                                  size: fIcon,
                                ),
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    widget.productQu += 1;
                                  });
                                }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                   :   Column()
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}


