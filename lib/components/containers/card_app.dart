import 'package:flutter/material.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';

bool special = true;
ContainerApp card_app(Widget child, {special = true,String? image}) {
  return ContainerApp(child:
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (special == true)

          Expanded(
            child: image_circle(
            imageString:   image!,
              radius: 36,
            ),
          ),
        if (special == true)        SizedBox(height: SizeConfig.scaleHeight(70),child: VerticalDivider(width: 15,thickness: .3,color: kSecondaryColor,)),

  SizedBox(child: child),
      ],
    ),

  );
}
