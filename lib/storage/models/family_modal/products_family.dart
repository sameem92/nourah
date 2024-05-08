class ProductsModalFamily {
  late int id;
  late int userId;
  late String arname;
  late String enname;
  late int category;
  late String ardesc;
  late String endesc;
  late int price;
  late int durationFrom;
  late int durationTo;
  late String durationUnit;
  late int offerDuration;
  late dynamic offertime;
  late String offerDurationUnit;
  late dynamic offerPrice;
  late int offerStatus;
  late dynamic offerDiscount;
  late String startDate;
  late String endDate;
  late String specialStartDate;
  late String specialEndDate;
  late String offerSpecialStartdate;
  late String offerSpecialEnddate;
  late int suspensed;
  late int deleted;
  late String createdAt;
  late List<Images>? images;

  ProductsModalFamily({
    required this.id,
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
    required this.offerStatus,
    required this.offerDiscount,
    required this.offertime,
    this.images,
  });

  ProductsModalFamily.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    arname = json['arname'] ?? '';
    enname = json['enname'] ?? '';
    category = json['category'];
    ardesc = json['ardesc'] ?? '';
    endesc = json['endesc'] ?? '';
    price = json['price'] ?? 0;
    offerStatus = json['offer_status'] ?? 0;
    durationFrom = json['duration_from'] ?? 0;
    offertime = json['offertime'];

    durationTo = json['duration_to'] ?? 0;
    durationUnit = json['duration_unit'] ?? 0;
    offerDuration = json['offer_duration'] ?? 0;
    offerDurationUnit = json['offer_duration_unit'] ?? '';
    offerPrice = json['offer_price'] ?? 0;
    offerDiscount = json['offer_discount'] ?? 0;
    startDate = json['start_date'] ?? '';
    endDate = json['end_date'] ?? '';
    specialStartDate = json['special_start_date'] ?? '';
    specialEndDate = json['special_end_date'] ?? '';
    offerSpecialStartdate = json['offer_special_startdate'] ?? '';
    offerSpecialEnddate = json['offer_special_enddate'] ?? '';
    suspensed = json['suspensed'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['arname'] = arname;
    data['enname'] = enname;
    data['category'] = category;
    data['offertime'] = offertime;

    data['ardesc'] = ardesc;
    data['offer_status'] = offerStatus;
    data['endesc'] = endesc;
    data['price'] = price;
    data['duration_from'] = durationFrom;
    data['duration_to'] = durationTo;
    data['duration_unit'] = durationUnit;
    data['offer_duration'] = offerDuration;
    data['offer_duration_unit'] = offerDurationUnit;
    data['offer_price'] = offerPrice;
    data['offer_discount'] = offerDiscount;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['special_start_date'] = specialStartDate;
    data['special_end_date'] = specialEndDate;
    data['offer_special_startdate'] = offerSpecialStartdate;
    data['offer_special_enddate'] = offerSpecialEnddate;
    data['suspensed'] = suspensed;
    data['deleted'] = deleted;
    data['created_at'] = createdAt;
    if (images != null) {
      data['images'] = images?.map((v) => v.toJson()).toList();
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
    id = json['id'] ?? 0;
    productId = json['product_id'] ?? 0;
    image = json['image'] ?? '';
    createdAt = json['created_at'] ?? '';
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

class MainCategoriesModalFamily {
  late int id;
  late String arname;
  late String enname;

  MainCategoriesModalFamily.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arname = json['arname'];
    enname = json['enname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['arname'] = arname;
    data['enname'] = enname;
    return data;
  }
}
