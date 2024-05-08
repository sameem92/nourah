

class GetOrderDeliveryRequestsModal {
 late int id;
 late int userId;
 late int orderId;
 late int deliveryDuration;
 late String deliveryDurationUnit;
 late dynamic shippingCost;
 late int status;
 late String createdAt;
 late String deliveryname;
 late String deliveryimage;
 late dynamic deliveryrate;


  GetOrderDeliveryRequestsModal.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    userId = json['user_id']??0;
    orderId = json['order_id']??0;
    deliveryDuration = json['delivery_duration']??0;
    deliveryDurationUnit = json['delivery_duration_unit']??"";
    shippingCost = json['shipping_cost']??0;
    status = json['status']??0;
    createdAt = json['created_at']??"";
    deliveryname = json['deliveryname']??"";
    deliveryimage = json['deliveryimage']??"";
    deliveryrate = json['deliveryrate']??0;
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
