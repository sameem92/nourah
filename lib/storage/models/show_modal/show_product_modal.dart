class BaseRexponse {
 late String message;
 late ShowProductModal? data;
 late String code;


  BaseRexponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new ShowProductModal.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class ShowProductModal {
 late int id;
 late int userId;
 late String arname;
 late String enname;
 late int price;
 late int durationFrom;
 late int durationTo;
 late String durationUnit;
 late int offerPrice;
 late int offerDiscount;
 late List<ImagesProduct>? images;
 late int rate;


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
        images?.add(new ImagesProduct.fromJson(v));
      });
    }
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['arname'] = this.arname;
    data['enname'] = this.enname;
    data['price'] = this.price;
    data['duration_from'] = this.durationFrom;
    data['duration_to'] = this.durationTo;
    data['duration_unit'] = this.durationUnit;
    data['offer_price'] = this.offerPrice;
    data['offer_discount'] = this.offerDiscount;
    if (this.images != null) {
      data['images'] = this.images?.map((v) => v.toJson()).toList();
    }
    data['rate'] = this.rate;
    return data;
  }
}

class ImagesProduct {
 late int id;
 late int productId;
 late String image;
 late String createdAt;


  ImagesProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}