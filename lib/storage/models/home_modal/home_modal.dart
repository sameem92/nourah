class HomeModal {
  late Data<Products> specialproducts;
  late Data<Products> products;

  late Data<Families> specialfamilies;
  late Data<Families> families;
  late Data<Offers> specialoffers;
  late Data<Offers> offers;
  late List<Categories> categories;

  late List<Coupons> coupons;

  HomeModal.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(Categories.fromJson(v));
      });
    }

    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) {
        coupons.add(Coupons.fromJson(v));
      });
    }

    specialproducts = (json['specialproducts'] != null
        ? Data<Products>.fromJson(json['specialproducts'])
        : null)!;

    if (json['products'] != null) {
      products = (json['products'] != null
          ? Data<Products>.fromJson(json['products'])
          : null)!;
    }
    // var jsonArray = jsonDecode(response.body)['data']['products'] as List;
    // newProducts = jsonArray
    //     .map((jsonObject) => Products.fromJson(jsonObject))
    //     .toList();

    specialfamilies = (json['specialfamilies'] != null
        ? Data<Families>.fromJson(json['specialfamilies'])
        : null)!;
    families = (json['families'] != null
        ? Data<Families>.fromJson(json['families'])
        : null)!;
    specialoffers = (json['specialoffers'] != null
        ? Data<Offers>.fromJson(json['specialoffers'])
        : null)!;
    offers = (json['offers'] != null
        ? Data<Offers>.fromJson(json['offers'])
        : null)!;
  }
}

class Data<T> {
  late int currentPage;
  List<T> data = [];
  late String firstPageUrl;
  late int? from;
  late int? lastPage;
  late String lastPageUrl;
  late String? nextPageUrl;
  late String path;
  late int? perPage;
  late String? prevPageUrl;
  late int? to;
  late int? total;

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <T>[];
      if (T == Products) {
        json['data'].forEach((v) {
          data.add(Products.fromJson(v) as T);
        });
      } else if (T == Families) {
        json['data'].forEach((v) {
          data.add(Families.fromJson(v) as T);
        });
      } else if (T == Offers) {
        json['data'].forEach((v) {
          data.add(Offers.fromJson(v) as T);
        });
      }
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class Categories {
  late int id;
  late String arname;
  late String enname;
  late int deleted;
  late int suspensed;
  late String createdAt;

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arname = json['arname'];
    enname = json['enname'];
    deleted = json['deleted'];
    suspensed = json['suspensed'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['arname'] = arname;
    data['enname'] = enname;
    data['deleted'] = deleted;
    data['suspensed'] = suspensed;
    data['created_at'] = createdAt;
    return data;
  }
}

class Products {
  late int id;
  late int userId;
  late String arname;
  late String enname;
  late int price;
  late int durationFrom;
  late int durationTo;
  late String durationUnit;
  late int category;
  late int brand;
  late int offerStatus;
  late dynamic offerPrice;
  late dynamic offerDiscount;
  late String images;
  late int km;
  late int familystatus;
  late dynamic familyrate;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    userId = json['user_id'] ?? 0;
    arname = json['arname'] ?? '';
    enname = json['enname'] ?? '';
    price = json['price'] ?? 0;
    brand = json['brand'] ?? 0;
    durationFrom = json['duration_from'] ?? 0;
    offerStatus = json['offer_status'] ?? 0;
    durationTo = json['duration_to'] ?? 0;
    durationUnit = json['duration_unit'] ?? '';
    offerPrice = json['offer_price'] ?? 0;
    category = json['category'] ?? 0;
    offerDiscount = json['offer_discount'] ?? 0;
    images = json['images'] ?? '';
    km = json['km'] ?? 0;
    familystatus = json['familystatus'] ?? 0;
    familyrate = json['familyrate'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['arname'] = arname;
    data['brand'] = brand;
    data['enname'] = enname;
    data['offer_status'] = offerStatus;
    data['category'] = category;
    data['price'] = price;
    data['duration_from'] = durationFrom;
    data['duration_to'] = durationTo;
    data['duration_unit'] = durationUnit;
    data['offer_price'] = offerPrice;
    data['offer_discount'] = offerDiscount;
    data['images'] = images;
    data['km'] = km;
    data['familystatus'] = familystatus;
    data['familyrate'] = familyrate;
    return data;
  }
}

class Families {
  late int id;
  late String name;
  late List<Categories> categories;
  late String image;
  late dynamic rate;
  late int available;
  late int mile;

  Families.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    name = json['name'] ?? "";
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(Categories.fromJson(v));
      });
    }
    image = json['image'] ?? '';
    rate = json['rate'] ?? 0;
    available = json['available'] ?? 0;
    mile = json['mile'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;

    data['categories'] = categories.map((v) => v.toJson()).toList();
    data['image'] = image;
    data['rate'] = rate;
    data['available'] = available;
    data['mile'] = mile;
    return data;
  }
}

class Offers {
  late int id;
  late int userId;
  late String arname;
  late String enname;
  late int price;
  late int category;
  late int brand;
  late int durationFrom;
  late int durationTo;
  late String durationUnit;
  late int offerDuration;
  late String offerDurationUnit;
  late int offerPrice;
  late int offerstatus;
  late dynamic offerDiscount;
  late String images;
  late int km;
  late int familystatus;
  late dynamic familyrate;
  late dynamic offertime;

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] ?? 0;
    brand = json['brand'] ?? 0;
    userId = json['user_id'];
    arname = json['arname'] ?? '';
    enname = json['enname'] ?? '';
    price = json['price'] ?? 0;
    offerstatus = json['offer_status'] ?? 0;
    durationFrom = json['duration_from'] ?? 0;
    durationTo = json['duration_to'] ?? 0;
    durationUnit = json['duration_unit'] ?? '';
    offerDuration = json['offer_duration'] ?? 0;
    offerDurationUnit = json['offer_duration_unit'] ?? '';
    offerPrice = json['offer_price'] ?? 0;
    offerDiscount = json['offer_discount'] ?? 0;
    images = json['images'];
    km = json['km'];
    familystatus = json['familystatus'];
    familyrate = json['familyrate'];
    offertime = json['offertime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['user_id'] = userId;
    data['arname'] = arname;
    data['enname'] = enname;
    data['price'] = price;
    data['duration_from'] = durationFrom;
    data['duration_to'] = durationTo;
    data['duration_unit'] = durationUnit;
    data['offer_duration'] = offerDuration;
    data['offer_duration_unit'] = offerDurationUnit;
    data['offer_price'] = offerPrice;
    data['offer_discount'] = offerDiscount;
    data['images'] = images;
    data['km'] = km;
    data['familystatus'] = familystatus;
    data['familyrate'] = familyrate;
    data['offertime'] = offertime;
    return data;
  }
}

class Coupons {
  late String? coupon;
  late String? image;
  late int? value;
  late String? valueType;

  Coupons.fromJson(Map<String, dynamic> json) {
    coupon = json['coupon'] ?? "";
    image = json['image'] ?? '';
    value = json['value'] ?? 0;
    valueType = json['value_type'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coupon'] = coupon;
    data['image'] = image;
    data['value'] = value;
    data['value_type'] = valueType;
    return data;
  }
}
