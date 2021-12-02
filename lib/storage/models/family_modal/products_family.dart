

class ProductsModalFamily {
late  int id;
late  int userId;
late  String arname;
late  String enname;
late  int category;
late  String ardesc;
late  String endesc;
late  String price;
late  String durationFrom;
late  String durationTo;
late  String durationUnit;
late  String offerDuration;
late  String offerDurationUnit;
late  String offerPrice;
late  int offerDiscount;
late  String startDate;
late  String endDate;
late  String specialStartDate;
late  String specialEndDate;
late  String offerSpecialStartdate;
late  String offerSpecialEnddate;
late  int suspensed;
late  int deleted;
late  String createdAt;
late  List<Images>? images;


ProductsModalFamily(
      {required this.id,
     required this.arname,
     required this.enname,
     required this.category,
     required this.ardesc,
     required this.endesc,
     required this.price,
     required this.durationFrom,
     required this.durationTo,
     required this.durationUnit,
     required this.offerDuration,
     required this.offerDurationUnit,
     required this.offerPrice,
     required this.offerDiscount,
      this.images,

    });

  ProductsModalFamily.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    arname = json['arname']??'';
    enname = json['enname']??'';
    category = json['category'];
    ardesc = json['ardesc']??'';
    endesc = json['endesc']??'';
    price = json['price'].toString();
    durationFrom = json['duration_from'].toString();
    durationTo = json['duration_to'].toString();
    durationUnit = json['duration_unit'];
    offerDuration = json['offer_duration'].toString();
    offerDurationUnit = json['offer_duration_unit']??'';
    offerPrice = json['offer_price'].toString();
    offerDiscount = json['offer_discount']??0;
    startDate = json['start_date'];
    endDate = json['end_date'];
    specialStartDate = json['special_start_date']??'';
    specialEndDate = json['special_end_date']??'';
    offerSpecialStartdate = json['offer_special_startdate']??'';
    offerSpecialEnddate = json['offer_special_enddate']??'';
    suspensed = json['suspensed'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images?.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['arname'] = this.arname;
    data['enname'] = this.enname;
    data['category'] = this.category;
    data['ardesc'] = this.ardesc;
    data['endesc'] = this.endesc;
    data['price'] = this.price;
    data['duration_from'] = this.durationFrom;
    data['duration_to'] = this.durationTo;
    data['duration_unit'] = this.durationUnit;
    data['offer_duration'] = this.offerDuration;
    data['offer_duration_unit'] = this.offerDurationUnit;
    data['offer_price'] = this.offerPrice;
    data['offer_discount'] = this.offerDiscount;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['special_start_date'] = this.specialStartDate;
    data['special_end_date'] = this.specialEndDate;
    data['offer_special_startdate'] = this.offerSpecialStartdate;
    data['offer_special_enddate'] = this.offerSpecialEnddate;
    data['suspensed'] = this.suspensed;
    data['deleted'] = this.deleted;
    data['created_at'] = this.createdAt;
    if (this.images != null) {
      data['images'] = this.images?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
 late int id;
 late int productId;
 late String image;
 late String createdAt;


  Images.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    productId = json['product_id']??0;
    image = json['image']??'';
    createdAt = json['created_at']??'';
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