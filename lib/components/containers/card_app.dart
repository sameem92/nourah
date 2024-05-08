import 'package:flutter/material.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';

bool special = true;

ContainerApp cardApp(Widget child, {special = true,String? image, Color? colorContainer=Colors.white}) {
  return ContainerApp(colorContainer:colorContainer ,child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // if (special == true)
        //
        //   Expanded(
        //     child: ImageCircle(
        //     imageString:   image!,
        //       radius: 36,
        //     ),
        //   ),
        // if (special == true)        SizedBox(height: SizeConfig.scaleHeight(70),child: VerticalDivider(width: 15,thickness: .3,color: kGrey.withOpacity(.5),)),

          ClipRRect(

            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            ),
            child: ImageContainer(
              image!,
              height: 200,
              width: double.infinity,
            ),
          ),

  Padding(
      padding: EdgeInsets.only(
        top: hSpace
            // ,bottom: hSpace
      ),
      child: child),
      ],
    ),

  );
}
