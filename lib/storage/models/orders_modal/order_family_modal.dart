class OrderFamilyModal {
  late int id;
  late String orderNo;
  late int userId;
  late int familyId;
  late int familyReply;
  late int ready;
  late int orderDuration;
  late String orderDurationUnit;
  late String familyNotes;
  late int deliveryId;
  late int deliveryReply;
  late int deliveryDuration;
  late String deliveryDurationUnit;
  late String clientNotes;
  late int paymentMethod;
  late int shippingLat;
  late int shippingLng;
  late String shippingTo;
  late String deliveryphone;
  late String familycomment;
  late String familyorderRate;

  late double shippingCost;
  late dynamic orderCost;

  late dynamic familyrate;
  late int coupon;
  late dynamic totalCost;
  late int paid;
  late int status;
  late int reported;
  late int archieved;
  late int suspensed;
  late int deleted;
  late String createdAt;
  late List<OrderDetails> orderDetails;

  OrderFamilyModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'] ?? "";
    userId = json['user_id'];
    familyId = json['family_id'];
    ready = json['ready'];
    familyReply = json['family_reply'];
    orderDuration = json['order_duration'] ?? 0;
    orderDurationUnit = json['order_duration_unit'] ?? '';
    familyorderRate = json['familyorder_rate'] ?? '';
    deliveryphone = json['deliveryphone'] ?? '';
    familyNotes = json['family_notes'] ?? '';
    deliveryId = json['delivery_id'] ?? 0;
    deliveryReply = json['delivery_reply'];
    deliveryDuration = json['delivery_duration'] ?? 0;
    deliveryDurationUnit = json['delivery_duration_unit'] ?? '';
    clientNotes = json['client_notes'] ?? '';
    paymentMethod = json['payment_method'];
    // shippingLat = json['shipping_lat']??0;
    // shippingLng = json['shipping_lng'];
    shippingTo = json['shipping_to'] ?? '';
    // shippingCost = json['shipping_cost']??'';
    orderCost = json['order_cost'];
    familyrate = json['familyrate'];
    coupon = json['coupon'];
    totalCost = json['total_cost'];
    paid = json['paid'];
    status = json['status'];
    reported = json['reported'];
    archieved = json['archieved'];
    suspensed = json['suspensed'];
    deleted = json['deleted'];
    familycomment = json['familycomment'] ?? '';

    createdAt = json['created_at'];
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
    data['family_reply'] = familyReply;
    data['ready'] = ready;
    data['order_duration'] = orderDuration;
    data['order_duration_unit'] = orderDurationUnit;
    data['family_notes'] = familyNotes;
    data['delivery_id'] = deliveryId;
    data['family_rate'] = deliveryId;
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
    data['familyrate'] = familyrate;

    data['reported'] = reported;
    data['archieved'] = archieved;
    data['suspensed'] = suspensed;
    data['deleted'] = deleted;
    data['familycomment'] = familycomment;

    data['created_at'] = createdAt;
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
  late dynamic productprice;
  late dynamic offerDiscount;

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'] ?? 0;
    productId = json['product_id'] ?? 0;
    offerDiscount = json['offer_discount'] ?? 0;
    qty = json['qty'] ?? 0;
    total = json['total'] ?? 0;
    createdAt = json['created_at'];
    arname = json['arname'] ?? '';
    enname = json['enname'] ?? '';
    productprice = json['productprice'] ?? 0;
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
