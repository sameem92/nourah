import 'package:flutter/material.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/style/style_field.dart';
TextEditingController _message=_message;

Padding message_admin_field(BuildContext context) {
  return Padding(
    padding: EdgeInsetsDirectional.only(
      start: wPadding,
      end: wPadding,
      top:hPadding,
      bottom: hPadding,
    ),
    child: Column(
      children: [
        StyleField(
          controller: _message,
          title: AppLocalizations.of(context)!.yourMessage,
          maxLines: 10,
          height: SizeConfig.scaleHeight(150),
          width: double.infinity,
        ),
        SizedBox(
          height: SizeConfig.scaleHeight(10),
        ),
        Row(
          children: [
            Spacer(),
            StyleButton(
              AppLocalizations.of(context)!.send,onPressed: (){},
              backgroundColor: kSpecialColor,
              sideColor: kSpecialColor,
              iconName: Icons.reply,
              iconColor: Colors.white,

            ),
          ],
        )
      ],
    ),
  );
}
