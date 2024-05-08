class GetUserOrdersModal {
  late int id;
  late String orderNo;
  late int userId;
  late int familyId;
  late int familyReply;
  late int orderDuration;
  late String deliveryphone;
  late String familyphone;
  late String orderDurationUnit;
  late String familyNotes;
  late int deliveryId;
  late int deliveryReply;
  late int deliveryDuration;
  late int ready;
  late String deliveryDurationUnit;
  late String clientNotes;
  late int paymentMethod;
  late dynamic shippingLat;
  late dynamic shippingLng;
  late String shippingTo;
  late int shippingCost;
  late dynamic orderCost;
  late int coupon;
  late dynamic totalCost;
  late int paid;
  late int status;
  late int offerDiscount;
  late int reported;
  late int archieved;
  late int suspensed;
  late int deleted;
  late String createdAt;
  late String familyname;
  late String familynotes;
  late String familyimage;
  late dynamic familylat;
  late dynamic familylng;
  late String familyaddress;
  late int km;
  late dynamic familyrate;
  late String deliveryname;
  late String deliveryimage;
  late dynamic familycomment;
  late dynamic deliverylat;
  late dynamic deliverylng;
  late dynamic deliveryrate;
  late dynamic deliveryorderRate;
  late dynamic familyorderRate;
  late List<GetDeliveryOrdersModal> deliveryoffers;
  late List<OrderDetails> orderDetails;

  GetUserOrdersModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'] ?? '';
    userId = json['user_id'];
    familyId = json['family_id'] ?? 0;
    deliveryphone = json['deliveryphone'] ?? '';
    familyReply = json['family_reply'];
    orderDuration = json['order_duration'] ?? 0;
    offerDiscount = json['offer_discount'] ?? 0;
    ready = json['ready'] ?? 0;
    familyphone = json['familyphone'] ?? '';
    orderDurationUnit = json['order_duration_unit'] ?? '';
    familyNotes = json['family_notes'] ?? '';
    deliveryId = json['delivery_id'] ?? 0;
    deliveryorderRate = json['deliveryorder_rate'] ?? 0;
    familyorderRate = json['familyorder_rate'] ?? 0;
    deliveryReply = json['delivery_reply'];
    deliveryDuration = json['delivery_duration'] ?? 0;
    deliveryDurationUnit = json['delivery_duration_unit'] ?? '';
    clientNotes = json['client_notes'] ?? '';
    paymentMethod = json['payment_method'];
    shippingLat = json['shipping_lat'] ?? 0;
    shippingLng = json['shipping_lng'] ?? 0;
    shippingTo = json['shipping_to'] ?? '';
    shippingCost = json['shipping_cost'] ?? 0;
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
    familyname = json['familyname'] ?? '';
    familynotes = json['familynotes'] ?? '';
    familyimage = json['familyimage'] ?? '';
    familylat = json['familylat'];
    familylng = json['familylng'];
    familyaddress = json['familyaddress'] ?? '';
    km = json['km'];
    familyrate = json['familyrate'];
    deliveryname = json['deliveryname'] ?? '';
    deliveryimage = json['deliveryimage'] ?? '';
    familycomment = json['familycomment'] ?? "";
    deliverylat = json['deliverylat'] ?? 0;
    deliverylng = json['deliverylng'] ?? 0;
    deliveryrate = json['deliveryrate'] ?? 0;
    if (json['deliveryoffers'] != null) {
      deliveryoffers = <GetDeliveryOrdersModal>[];
      json['deliveryoffers'].forEach((v) {
        deliveryoffers.add(GetDeliveryOrdersModal.fromJson(v));
      });
    }
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
    data['deliveryphone'] = deliveryphone;
    data['familyphone'] = familyphone;
    data['family_reply'] = familyReply;
    data['order_duration'] = orderDuration;
    data['order_duration_unit'] = orderDurationUnit;
    data['family_notes'] = familyNotes;
    data['ready'] = ready;
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
    data['familynotes'] = familynotes;
    data['familyimage'] = familyimage;
    data['familylat'] = familylat;
    data['familylng'] = familylng;
    data['familyaddress'] = familyaddress;
    data['km'] = km;
    data['familyrate'] = familyrate;
    data['deliveryname'] = deliveryname;
    data['deliveryimage'] = deliveryimage;
    data['familycomment'] = familycomment;
    data['deliverylat'] = deliverylat;
    data['deliverylng'] = deliverylng;
    data['deliveryrate'] = deliveryrate;
    data['deliveryoffers'] = deliveryoffers.map((v) => v.toJson()).toList();
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
  late int offerStatus;
  late dynamic offerPrice;
  late dynamic offerDiscount;

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'] ?? 0;
    productId = json['product_id'] ?? 0;
    offerStatus = json['offer_status'] ?? 0;
    offerDiscount = json['offer_discount'] ?? 0;
    offerPrice = json['offer_price'] ?? 0;
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

class GetDeliveryOrdersModal {
  late int id;
  late int userId;
  late int orderId;
  late int deliveryDuration;
  late String deliveryDurationUnit;
  late String shippingCost;
  late int status;
  late String createdAt;
  late String deliveryname;
  late String deliveryimage;
  late int deliveryrate;

  GetDeliveryOrdersModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    deliveryDuration = json['delivery_duration'];
    deliveryDurationUnit = json['delivery_duration_unit'];
    shippingCost = json['shipping_cost'] ?? '';
    status = json['status'];
    createdAt = json['created_at'];
    deliveryname = json['deliveryname'];
    deliveryimage = json['deliveryimage'];
    deliveryrate = json['deliveryrate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['order_id'] = orderId;
    data['delivery_duration'] = deliveryDuration;
    data['delivery_duration_unit'] = deliveryDurationUnit;
    data['shipping_cost'] = shippingCost;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['deliveryname'] = deliveryname;
    data['deliveryimage'] = deliveryimage;
    data['deliveryrate'] = deliveryrate;
    return data;
  }
}

class ProductRowModal {
  late int id;
  late int orderId;
  late int productId;
  late int qty;
  late int total;
  late String createdAt;
  late String productname;
  late int productprice;

  ProductRowModal.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['qty'] = qty;
    data['total'] = total;
    data['created_at'] = createdAt;
    data['productname'] = productname;
    data['productprice'] = productprice;
    return data;
  }
}

// class GetUserFollowOrdersModal {
//   late int id;
//   late String orderNo;
//   late int userId;
//   late int familyId;
//   late int familyReply;
//   late int orderDuration;
//   late String orderDurationUnit;
//   late String familyNotes;
//   late int deliveryId;
//   late int deliveryReply;
//   late int deliveryDuration;
//   late String deliveryDurationUnit;
//   late String deliveryphone;
//   late String familyphone;
//   late String clientNotes;
//   late int paymentMethod;
//   late dynamic shippingLat;
//   late dynamic shippingLng;
//   late String shippingTo;
//   late int shippingCost;
//   late int orderCost;
//   late int coupon;
//   late int totalCost;
//   late int paid;
//   late int status;
//   late int reported;
//   late int archieved;
//   late int suspensed;
//   late int deleted;
//   late String createdAt;
//   late String familyname;
//   late String familynotes;
//   late String familyimage;
//   // late double familylat;
//   // late double familylng;
//   // late String familyaddress;
//   late int km;
//   late int familyrate;
//   late String deliveryname;
//   late String deliveryimage;
//   late dynamic deliverylat;
//   late dynamic deliverylng;
//   late int deliveryrate;
//   late List<GetDeliveryOrdersModal> deliveryoffers;
//   late List<OrderDetails> orderDetails;
//
//
//
//   GetUserFollowOrdersModal.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     orderNo = json['order_no'];
//     userId = json['user_id'];
//     familyId = json['family_id']??0;
//     familyReply = json['family_reply'];
//     orderDuration = json['order_duration']??0;
//     orderDurationUnit = json['order_duration_unit']??'';
//     familyNotes = json['family_notes']??'';
//     deliveryphone = json['delivery_phone']??'';
//     familyphone = json['familyphone']??'';
//     deliveryId = json['delivery_id']??0;
//     deliveryReply = json['delivery_reply'];
//     deliveryDuration = json['delivery_duration']??0;
//     deliveryDurationUnit = json['delivery_duration_unit']??'';
//     clientNotes = json['client_notes']??'';
//     paymentMethod = json['payment_method'];
//     shippingLat = json['shipping_lat']??0;
//     shippingLng = json['shipping_lng'];
//     shippingTo = json['shipping_to']??'';
//     shippingCost = json['shipping_cost']??0;
//     orderCost = json['order_cost'];
//     coupon = json['coupon'];
//     totalCost = json['total_cost'];
//     paid = json['paid'];
//     status = json['status'];
//     reported = json['reported'];
//     archieved = json['archieved'];
//     suspensed = json['suspensed'];
//     deleted = json['deleted'];
//     createdAt = json['created_at'];
//     familyname = json['familyname']??'';
//     familynotes = json['familynotes']??'';
//     familyimage = json['familyimage']??'';
//     // familylat = json['familylat'];
//     // familylng = json['familylng'];
//     // familyaddress = json['familyaddress']??'';
//     km = json['km'];
//     familyrate = json['familyrate'];
//     deliveryname = json['deliveryname']??'';
//     deliveryimage = json['deliveryimage']??'';
//     deliverylat = json['deliverylat']??0;
//     deliverylng = json['deliverylng']??0;
//     deliveryrate = json['deliveryrate']??0;
//     if (json['deliveryoffers'] != null) {
//       deliveryoffers =<GetDeliveryOrdersModal>[];
//       json['deliveryoffers'].forEach((v) {
//         deliveryoffers.add(new GetDeliveryOrdersModal.fromJson(v));
//       });
//     }
//     if (json['order_details'] != null) {
//       orderDetails = <OrderDetails>[];
//       json['order_details'].forEach((v) {
//         orderDetails.add(new OrderDetails.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['order_no'] = this.orderNo;
//     data['user_id'] = this.userId;
//     data['family_id'] = this.familyId;
//     data['family_reply'] = this.familyReply;
//     data['order_duration'] = this.orderDuration;
//     data['order_duration_unit'] = this.orderDurationUnit;
//     data['family_notes'] = this.familyNotes;
//     data['delivery_id'] = this.deliveryId;
//     data['delivery_reply'] = this.deliveryReply;
//     data['delivery_duration'] = this.deliveryDuration;
//     data['delivery_duration_unit'] = this.deliveryDurationUnit;
//     data['client_notes'] = this.clientNotes;
//     data['payment_method'] = this.paymentMethod;
//     data['shipping_lat'] = this.shippingLat;
//     data['shipping_lng'] = this.shippingLng;
//     data['shipping_to'] = this.shippingTo;
//     data['shipping_cost'] = this.shippingCost;
//     data['order_cost'] = this.orderCost;
//     data['coupon'] = this.coupon;
//     data['total_cost'] = this.totalCost;
//     data['paid'] = this.paid;
//     data['status'] = this.status;
//     data['reported'] = this.reported;
//     data['archieved'] = this.archieved;
//     data['suspensed'] = this.suspensed;
//     data['deleted'] = this.deleted;
//     data['created_at'] = this.createdAt;
//     data['familyname'] = this.familyname;
//     data['familynotes'] = this.familynotes;
//     data['familyimage'] = this.familyimage;
//     // data['familylat'] = this.familylat;
//     // data['familylng'] = this.familylng;
//     // data['familyaddress'] = this.familyaddress;
//     data['km'] = this.km;
//     data['familyrate'] = this.familyrate;
//     data['deliveryname'] = this.deliveryname;
//     data['deliveryimage'] = this.deliveryimage;
//     data['deliverylat'] = this.deliverylat;
//     data['deliverylng'] = this.deliverylng;
//     data['deliveryrate'] = this.deliveryrate;
//     if (this.deliveryoffers != null) {
//       data['deliveryoffers'] =
//           this.deliveryoffers.map((v) => v.toJson()).toList();
//     }
//     if (this.orderDetails != null) {
//       data['order_details'] = this.orderDetails.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
