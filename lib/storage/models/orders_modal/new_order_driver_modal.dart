class NewOrderDriverModal {
 late int id;
 late String orderNo;
 late String orderDate;
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
 late int clientConfirmed;
 late int paymentMethod;
 late double shippingLat;
 late double shippingLng;
 late String shippingTo;
 late dynamic shippingCost;
 late dynamic orderCost;
 late int coupon;
 late dynamic totalCost;
 late int paid;
 late int status;
 late int reported;
 late int archieved;
 late int suspensed;
 late int deleted;
 late String createdAt;
 late String familyname;
 late String familyphone;
 late dynamic familylat;
 late dynamic familylng;
 late String familyaddress;
 late dynamic familyrate;
 late dynamic deliveryrate;
 late String clientname;
 late String clientphone;
 late double clientlat;
 late double clientlng;
 late List<OrderDetails> orderDetails;



  NewOrderDriverModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no']??"";
    orderDate = json['order_date']??"";
    userId = json['user_id']??0;
    familyId = json['family_id']??0;
    familyReply = json['family_reply']??0;
    orderDuration = json['order_duration']??0;
    orderDurationUnit = json['order_duration_unit']??'';
    familyNotes = json['family_notes']??'';
    deliveryId = json['delivery_id']??0;
    deliveryReply = json['delivery_reply']??0;
    deliveryDuration = json['delivery_duration']??0;
    deliveryDurationUnit = json['delivery_duration_unit']??"";
    clientNotes = json['client_notes']??"";
    clientConfirmed = json['client_confirmed']??0;
    paymentMethod = json['payment_method'];
    shippingLat = json['shipping_lat']??0;
    shippingLng = json['shipping_lng']??0;
    shippingTo = json['shipping_to']??"";
    shippingCost = json['shipping_cost']??0;
    orderCost = json['order_cost']??0;
    coupon = json['coupon']??0;
    totalCost = json['total_cost']??0;
    paid = json['paid'];
    status = json['status']??0;
    reported = json['reported'];
    archieved = json['archieved'];
    suspensed = json['suspensed'];
    deleted = json['deleted'];
    createdAt = json['created_at']??'';
    familyname = json['familyname']??'';
    familyphone = json['familyphone']??"";
    familylat = json['familylat']??0;
    familylng = json['familylng']??0;
    familyaddress = json['familyaddress']??'';
    familyrate = json['familyrate']??0;
    deliveryrate = json['deliveryrate']??0;
    clientname = json['clientname']??"";
    clientphone = json['clientphone']??'';
    clientlat = json['clientlat']??0;
    clientlng = json['clientlng']??0;
    if (json['order_details'] != null) {
      orderDetails =  <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails.add(OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_no'] = orderNo;
    data['order_date'] = orderDate;
    data['user_id'] = userId;
    data['family_id'] = familyId;
    data['family_reply'] = familyReply;
    data['order_duration'] = orderDuration;
    data['order_duration_unit'] = orderDurationUnit;
    data['family_notes'] = familyNotes;
    data['delivery_id'] = deliveryId;
    data['delivery_reply'] = deliveryReply;
    data['delivery_duration'] = deliveryDuration;
    data['delivery_duration_unit'] = deliveryDurationUnit;
    data['client_notes'] = clientNotes;
    data['client_confirmed'] = clientConfirmed;
    data['payment_method'] = paymentMethod;
    data['shipping_lat'] = shippingLat;
    data['shipping_lng'] = shippingLng;
    data['shipping_to'] = shippingTo;
    data['shipping_cost'] = shippingCost;
    data['order_cost'] = orderCost;
    data['coupon'] = coupon;
    data['total_cost'] = totalCost;
    data['paid'] = paid;
    data['status'] = status;
    data['reported'] = reported;
    data['archieved'] = archieved;
    data['suspensed'] = suspensed;
    data['deleted'] = deleted;
    data['created_at'] = createdAt;
    data['familyname'] = familyname;
    data['familyphone'] = familyphone;
    data['familylat'] = familylat;
    data['familylng'] = familylng;
    data['familyaddress'] = familyaddress;
    data['familyrate'] = familyrate;
    data['deliveryrate'] = deliveryrate;
    data['clientname'] = clientname;
    data['clientphone'] = clientphone;
    data['clientlat'] = clientlat;
    data['clientlng'] = clientlng;
    data['order_details'] = orderDetails.map((v) => v.toJson()).toList();
    return data;
  }
}

class OrderDetails {
 late int id;
 late int orderId;
 late int productId;
 late int offerStatus;
 late int qty;
 late dynamic total;
 late String arname;
 late String enname;
 late String createdAt;
 late int productprice;
 late dynamic offerDiscount;



  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    offerDiscount = json['offer_discount'];
    offerStatus = json['offer_status'];
    qty = json['qty']??0;
    total = json['total']??0;
    arname = json['arname']??'';
    enname = json['enname']??'';
    createdAt = json['created_at'];
    productprice = json['productprice']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['offer_status'] = offerStatus;
    data['qty'] = qty;
    data['total'] = total;
    data['arname'] = arname;
    data['enname'] = enname;
    data['created_at'] = createdAt;
    data['productprice'] = productprice;
    return data;
  }
}