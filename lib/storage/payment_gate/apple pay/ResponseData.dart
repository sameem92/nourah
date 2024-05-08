

class ResponseData
{  final String TranId;
final String ResponseCode;
final String amount;
final String result;
final String payId;
final String cardToken;


ResponseData({required this.TranId,required this.ResponseCode,required this.amount,required this.result,
  required  this.payId,required this.cardToken});

factory ResponseData.fromJson(Map<String, dynamic> json) {
  return ResponseData(
    TranId: json['TranId'],
    ResponseCode: json['ResponseCode'],
    amount: json['amount'],
    result: json['result'],
    payId: json['payId'],
    cardToken: json['cardToken'],

  );
}

Map toMap() {
  var map = new Map<String, dynamic>();
  map["TranId"] = TranId;
  map["ResponseCode"] =ResponseCode;
  map["amount"] =amount;
  map["result"] =result;
  map["payId"] =payId;
  map["cardToken"] =cardToken;
  return map;
}
}
