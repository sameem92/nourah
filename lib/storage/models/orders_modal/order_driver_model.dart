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
  late String familyphone;
  late String clientphone;
  late int paymentMethod;
  late dynamic shippingLat;
  late dynamic shippingLng;
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
  late dynamic familylat;
  late dynamic familylng;
  late String familyaddress;
  late dynamic familyrate;
  late dynamic deliveryrate;
  late int deliveryorderRate;
  late int ready;
  late String clientname;
  late double clientlat;
  late double clientlng;
  late List<OrderDetails> orderDetails;

  OrderDriverModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'] ?? '';
    userId = json['user_id'];
    familyId = json['family_id'];
    familyReply = json['family_reply'];
    deliveryorderRate = json['deliveryorder_rate'] ?? 0;
    orderDuration = json['order_duration'] ?? 0;
    orderDurationUnit = json['order_duration_unit'] ?? '';
    familyphone = json['familyphone'] ?? '';
    clientphone = json['clientphone'] ?? '';
    familyNotes = json['family_notes'] ?? '';
    deliveryId = json['delivery_id'];
    deliveryReply = json['delivery_reply'];
    deliveryDuration = json['delivery_duration'] ?? 0;
    ready = json['ready'] ?? 0;
    deliveryDurationUnit = json['delivery_duration_unit'] ?? '';
    clientNotes = json['client_notes'] ?? '';
    paymentMethod = json['payment_method'];
    shippingLat = json['shipping_lat'] ?? 0;
    shippingLng = json['shipping_lng'] ?? 0;
    shippingTo = json['shipping_to'] ?? "";
    shippingCost = json['shipping_cost'] ?? 0;
    orderCost = json['order_cost'] ?? 0;
    coupon = json['coupon'] ?? 0;
    totalCost = json['total_cost'] ?? 0;
    paid = json['paid'];
    status = json['status'];
    reported = json['reported'];
    archieved = json['archieved'];
    suspensed = json['suspensed'];
    deleted = json['deleted'];
    createdAt = json['created_at'] ?? "";
    familyname = json['familyname'] ?? "";
    familylat = json['familylat'] ?? 0.0;
    familylng = json['familylng'] ?? 0.0;
    familyaddress = json['familyaddress'] ?? "";
    familyrate = json['familyrate'] ?? 0;
    deliveryrate = json['deliveryrate'] ?? 0;
    clientname = json['clientname'] ?? "";
    clientlat = json['clientlat'] ?? 0;
    clientlng = json['clientlng'] ?? 0;
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails.add(OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_no'] = orderNo;
    data['user_id'] = userId;
    data['family_id'] = familyId;
    data['ready'] = ready;
    data['family_reply'] = familyReply;
    data['order_duration'] = orderDuration;
    data['order_duration_unit'] = orderDurationUnit;
    data['family_notes'] = familyNotes;
    data['delivery_id'] = deliveryId;
    data['delivery_reply'] = deliveryReply;
    data['delivery_duration'] = deliveryDuration;
    data['delivery_duration_unit'] = deliveryDurationUnit;
    data['client_notes'] = clientNotes;
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
    data['familylat'] = familylat;
    data['familylng'] = familylng;
    data['familyaddress'] = familyaddress;
    data['familyrate'] = familyrate;
    data['deliveryrate'] = deliveryrate;
    data['clientname'] = clientname;
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
  late int qty;
  late dynamic total;
  late String createdAt;
  late String arname;
  late String enname;
  late int productprice;
  late dynamic offerDiscount;

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    offerDiscount = json['offer_discount'];
    qty = json['qty'];
    total = json['total'];
    createdAt = json['created_at'];
    arname = json['arname'] ?? '';
    enname = json['enname'] ?? '';
    productprice = json['productprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['qty'] = qty;
    data['total'] = total;
    data['created_at'] = createdAt;
    data['arname'] = arname;
    data['enname'] = enname;
    data['productprice'] = productprice;
    return data;
  }
}
