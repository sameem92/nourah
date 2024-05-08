import 'package:flutter/material.dart';

import '../../../style/style_button.dart';

class ReceiptPage extends StatefulWidget {
  final String transId;
  final String result;
  final String amount;

  final String cardToken;
  final String cardBrand;
  final String MaskedPan;

  ReceiptPage(this.transId, this.result, this.amount, this.cardToken,
      this.cardBrand, this.MaskedPan);

  @override
  _MyReceiptPage createState() => _MyReceiptPage();
}

class _MyReceiptPage extends State<ReceiptPage> {
  bool visibilityToken = false;

  void _visibleTokenDetails() {
    setState(() {
      var tok = widget.cardToken;
      print('Token $tok');

      if (tok == null || tok == "" || tok == "null") {
        print('Token if$tok');
        visibilityToken = false;
      } else {
        print('Token else$tok');
        visibilityToken = true;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _visibleTokenDetails();
  }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text('Urway Receipt'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text.rich(
              TextSpan(
                text: '', // default text style

                children: <TextSpan>[
                  TextSpan(
                      text: 'Order Summary',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24.0)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
              child: Text.rich(
                TextSpan(
                  text: 'Invoice Order # ', // default text style
                  children: <TextSpan>[
                    TextSpan(
                        text: widget.transId,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Transaction is ', // default text style
                children: <TextSpan>[
                  TextSpan(
                      text: widget.result,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Order Date ', // default text style
                children: <TextSpan>[
                  TextSpan(
                      text: '$now',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            Text.rich(
              TextSpan(
                text: 'Amount ', // default text style
                children: <TextSpan>[
                  TextSpan(
                      text: widget.amount,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Card Brand ', // default text style
                children: <TextSpan>[
                  TextSpan(
                      text: widget.cardBrand,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Masked Card No. ', // default text style
                children: <TextSpan>[
                  TextSpan(
                      text: widget.MaskedPan,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            visibilityToken
                ? new Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                    child: Text.rich(
                      TextSpan(
                        // default text style
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Token Details',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  )
                : new Container(),
            visibilityToken
                ? new Text.rich(
                    TextSpan(
                      text: 'Card Token  ', // default text style
                      children: <TextSpan>[
                        TextSpan(
                            text: widget.cardToken,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                : new Container(),
            StyleButton(
              "New Transaction",
              backgroundColor: Colors.blue,

              // width: SizeConfig.scaleWidth(230),

              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            // ElevatedButton(
            //   onPressed: ()
            //   {
            //     Navigator.pop(context);
            //   },
            //   color: Colors.blue,
            //   shape: new RoundedRectangleBorder(
            //       borderRadius: new BorderRadius.circular(10.0)),
            //
            //   child: Text("New Transaction",),
            // ),
          ],
        ),
      ),
    );
  }
}
