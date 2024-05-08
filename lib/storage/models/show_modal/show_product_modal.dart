class BaseRexponse {
 late dynamic message;
 late  ShowProductModal? data;
 late dynamic code;


  BaseRexponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? ShowProductModal.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['code'] = code;
    return data;
  }
}

class ShowProductModal {
 late dynamic id;
 late dynamic userId;
 late dynamic arname;
 late dynamic enname;
 late dynamic price;
 late dynamic durationFrom;
 late dynamic durationTo;
 late dynamic durationUnit;
 late dynamic offerPrice;
 late dynamic offerDiscount;
 late List<ImagesProduct>? images;
 late dynamic rate;


  ShowProductModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    arname = json['arname'];
    enname = json['enname'];
    price = json['price'];
    durationFrom = json['duration_from'];
    durationTo = json['duration_to'];
    durationUnit = json['duration_unit'];
    offerPrice = json['offer_price'];
    offerDiscount = json['offer_discount'];
    if (json['images'] != null) {
      images = <ImagesProduct>[];
      json['images'].forEach((v) {
        images?.add(ImagesProduct.fromJson(v));
      });
    }
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['arname'] = arname;
    data['enname'] = enname;
    data['price'] = price;
    data['duration_from'] = durationFrom;
    data['duration_to'] = durationTo;
    data['duration_unit'] = durationUnit;
    data['offer_price'] = offerPrice;
    data['offer_discount'] = offerDiscount;
    if (images != null) {
      data['images'] = images?.map((v) => v.toJson()).toList();
    }
    data['rate'] = rate;
    return data;
  }
}

class ImagesProduct {
 late dynamic id;
 late dynamic productId;
 late dynamic image;
 late dynamic createdAt;


  ImagesProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['image'] = image;
    data['created_at'] = createdAt;
    return data;
  }
}