class OrderDriverModal {
late int id;
late String orderNo;
late int userId;
late int familyId;
late int familyReply;
late int orderDuration;
late String orderDurationUnit;
late String familyNotes;
late int deliveryId;
late int deliveryReply;
late int deliveryDuration;
late String deliveryDurationUnit;
late String clientNotes;
late int paymentMethod;
late dynamic shippingLat;
late dynamic shippingLng;
late String shippingTo;
late int shippingCost;
late int orderCost;
late int coupon;
late int totalCost;
late int paid;
late int status;
late int reported;
late int archieved;
late int suspensed;
late int deleted;
late String createdAt;
late String familyname;
late dynamic familylat;
late dynamic familylng;
late String familyaddress;
late int familyrate;
late int deliveryrate;
late String clientname;
late dynamic clientlat;
late dynamic clientlng;
late List<OrderDetails> orderDetails;


  OrderDriverModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'];
    userId = json['user_id'];
    familyId = json['family_id'];
    familyReply = json['family_reply'];
    orderDuration = json['order_duration']??0;
    orderDurationUnit = json['order_duration_unit']??'';
    familyNotes = json['family_notes']??'';
    deliveryId = json['delivery_id'];
    deliveryReply = json['delivery_reply'];
    deliveryDuration = json['delivery_duration'];
    deliveryDurationUnit = json['delivery_duration_unit'];
    clientNotes = json['client_notes'];
    paymentMethod = json['payment_method'];
    shippingLat = json['shipping_lat']??0;
    shippingLng = json['shipping_lng']??0;
    shippingTo = json['shipping_to'];
    shippingCost = json['shipping_cost']??0;
    orderCost = json['order_cost'];
    coupon = json['coupon'];
    totalCost = json['total_cost'];
    paid = json['paid'];
    status = json['status'];
    reported = json['reported'];
    archieved = json['archieved'];
    suspensed = json['suspensed'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    familyname = json['familyname'];
    familylat = json['familylat']??0;
    familylng = json['familylng']??0;
    familyaddress = json['familyaddress']??"";
    familyrate = json['familyrate'];
    deliveryrate = json['deliveryrate'];
    clientname = json['clientname'];
    clientlat = json['clientlat']??0;
    clientlng = json['clientlng']??0;
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_no'] = this.orderNo;
    data['user_id'] = this.userId;
    data['family_id'] = this.familyId;
    data['family_reply'] = this.familyReply;
    data['order_duration'] = this.orderDuration;
    data['order_duration_unit'] = this.orderDurationUnit;
    data['family_notes'] = this.familyNotes;
    data['delivery_id'] = this.deliveryId;
    data['delivery_reply'] = this.deliveryReply;
    data['delivery_duration'] = this.deliveryDuration;
    data['delivery_duration_unit'] = this.deliveryDurationUnit;
    data['client_notes'] = this.clientNotes;
    data['payment_method'] = this.paymentMethod;
    data['shipping_lat'] = this.shippingLat;
    data['shipping_lng'] = this.shippingLng;
    data['shipping_to'] = this.shippingTo;
    data['shipping_cost'] = this.shippingCost;
    data['order_cost'] = this.orderCost;
    data['coupon'] = this.coupon;
    data['total_cost'] = this.totalCost;
    data['paid'] = this.paid;
    data['status'] = this.status;
    data['reported'] = this.reported;
    data['archieved'] = this.archieved;
    data['suspensed'] = this.suspensed;
    data['deleted'] = this.deleted;
    data['created_at'] = this.createdAt;
    data['familyname'] = this.familyname;
    data['familylat'] = this.familylat;
    data['familylng'] = this.familylng;
    data['familyaddress'] = this.familyaddress;
    data['familyrate'] = this.familyrate;
    data['deliveryrate'] = this.deliveryrate;
    data['clientname'] = this.clientname;
    data['clientlat'] = this.clientlat;
    data['clientlng'] = this.clientlng;
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
 late int id;
 late int orderId;
 late int productId;
 late int qty;
 late int total;
 late String createdAt;
 late String productname;
 late int productprice;


  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    qty = json['qty'];
    total = json['total'];
    createdAt = json['created_at'];
    productname = json['productname'];
    productprice = json['productprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['qty'] = this.qty;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['productname'] = this.productname;
    data['productprice'] = this.productprice;
    return data;
  }
}