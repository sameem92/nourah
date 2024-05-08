// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/storage/payment_gate/resp_data_model.dart';
import 'package:producer_family_app/style/style_text.dart';

import '../../components/headers/app_bar_family.dart';
import '../../screens/navigation_botton_screens/user_home_screen/main_screen.dart';
import '../../style/size_config.dart';
import '../../style/style_button.dart';
import '../../style/style_colors.dart';

class ReceiptUpdatedPage extends StatefulWidget {
  final String respFinalData;
  // ignore: use_key_in_widget_constructors
  const ReceiptUpdatedPage(this.respFinalData);

  @override
  // ignore: library_private_types_in_public_api
  _MyReceiptPage createState() => _MyReceiptPage();
}

class _MyReceiptPage extends State<ReceiptUpdatedPage> {
  late Map<String, dynamic> mapResp;
  bool visibilityToken = false;
  List list = [];
  Map<String, String> mapData = {};
  late String myData;

  void _visibleDataList() {
    if (!mounted) {
    } else {
      setState(() {
        var dataSp = widget.respFinalData.split(',');
        // print(widget.respFinalData);

        for (var element in dataSp) {
         print(mapData[element.split(':')[0]] = element.split(':')[1]);
         // mapData[element.split(':')[0]] = element.split(':')[1];
        }
        // print(mapData.keys);

        // mapResp = widget.respFinalData;
        mapData
            .forEach((k, v) => list.add(RespDataModel(resKey: k, resValue: v)));
        // print(list);
      });
    }
  }

  String getstrfromList(String strlistrowvalue) {
    myData = strlistrowvalue.replaceAll(RegExp('[{}]'), '');
    // print(myData);
    return myData;
  }

  //}

  @override
  void initState() {
    super.initState();
    _visibleDataList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // appBar: AppBar(
        //     automaticallyImplyLeading: false,
        //     backgroundColor: kSpecialColor,
        //     title: StyleText(
        //       AppLocalizations.of(context)!.operationResult,
        //     )),
        appBar: appBarWhite(context,
            iconBack: null,
            back: false,
            backOk: false,
            onPressedBackBool: false,
            main: true,
            title: AppLocalizations.of(context)!.operationResult,
            onPressed: () {}),
        body: Column(
          children: <Widget>[
            Expanded(
              child: tableBody(
                context,
              ),
            ),
            SizedBox(
              height: hSpaceLargevv,
            ),
            SizedBox(
              width: SizeConfig.scaleWidth(270),
              child: StyleButton(
                  widget.respFinalData.contains("Successful")
                      ? AppLocalizations.of(context)!.continueUp
                      : AppLocalizations.of(context)!.resultBack,
                  // width: double.infinity,
                  backgroundColor: kSpecialColor,
                  sideColor: kSpecialColor, onPressed: () async {
                widget.respFinalData.contains("Successful")
                    &&
                    widget.respFinalData.contains("000")==true &&
                    widget.respFinalData.contains("unSuccessful")!=true

                ?
                Navigator.pushReplacement(
                    context,

                         MaterialPageRoute(
                            builder: (context) => const MainScreen(
                                  currentIndex: 1,
                                  orderIndex: 0,
                                )))
                    :Navigator.pop(context);
                // :Navigator.
                    // MaterialPageRoute(
                    //         builder: (context) => const MainScreen(
                    //               currentIndex: 2,
                    //               orderIndex: 0,
                    //             )));
              }),
            ),
            SizedBox(
              height: hSpaceLargevv,
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView tableBody(BuildContext ctx) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            DataTable(
              dataRowHeight: 50,
              dividerThickness: 5,
              columns: [
                DataColumn(
                  label: StyleText('key', textColor: kSpecialColor),
                  numeric: false,
                  tooltip: "This is First Name",
                ),
                DataColumn(
                  label: StyleText('value', textColor: kSpecialColor),
                  numeric: false,
                  tooltip: "This is Values",
                ),
              ],
              rows: list
                  .map(
                    (list) => DataRow(cells: [
                      DataCell(
                        Text(getstrfromList(list.resKey)),
                      ),
                      DataCell(
                        Text(getstrfromList(list.resValue)),
                      ),
                    ]),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
