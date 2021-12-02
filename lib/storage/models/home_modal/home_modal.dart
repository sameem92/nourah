
class HomeModal {
  late Data<Products> specialproducts;
  late Data<Products> products;
  late Data<Families> specialfamilies;
  late Data<Families> families;
  late Data<Offers>   specialoffers;
  late Data<Offers>   offers;


  HomeModal.fromJson(Map<String, dynamic> json) {
    specialproducts = (json['specialproducts'] != null
        ? Data<Products>.fromJson(json['specialproducts'])
        : null)!;
    products = (json['products'] != null
        ? Data<Products>.fromJson(json['products'])
        : null)!;
    specialfamilies = (json['specialfamilies'] != null
        ? Data<Families>.fromJson(json['specialfamilies'])
        : null)!;
    families = (json['families'] != null
        ? Data<Families>.fromJson(json['families'])
        : null)!;
    specialoffers = (json['specialoffers'] != null
        ? Data<Offers>.fromJson(json['specialoffers'])
        : null)!;
    offers =
        (json['offers'] != null ? Data<Offers>.fromJson(json['offers']) : null)!;
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
  late int offerPrice;
  late int offerDiscount;
  late String images;
  late int km;
  late int familystatus;
  late int familyrate;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    arname = json['arname'] ?? '';
    enname = json['enname'] ?? '';
    price = json['price'] ?? 0;
    durationFrom = json['duration_from'] ?? 0;
    durationTo = json['duration_to'] ?? 0;
    durationUnit = json['duration_unit'] ?? '';
    offerPrice = json['offer_price'] ?? 0;
    category = json['category'] ?? 0;
    offerDiscount = json['offer_discount'] ?? 0;
    images = json['images'];
    km = json['km'];
    familystatus = json['familystatus'];
    familyrate = json['familyrate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['arname'] = this.arname;
    data['enname'] = this.enname;
    data['category'] = this.category;
    data['price'] = this.price;
    data['duration_from'] = this.durationFrom;
    data['duration_to'] = this.durationTo;
    data['duration_unit'] = this.durationUnit;
    data['offer_price'] = this.offerPrice;
    data['offer_discount'] = this.offerDiscount;
    data['images'] = this.images;
    data['km'] = this.km;
    data['familystatus'] = this.familystatus;
    data['familyrate'] = this.familyrate;
    return data;
  }
}

class Families {
  late int id;
  late String name;
  late List<Categories>? categories;
  late String image;
  late int rate;

  late int available;
  late int mile;

  Families.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    name = json['name'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories?.add(new Categories.fromJson(v));
      });
    }
    image = json['image'];
    rate = json['rate'];
    available = json['available'];
    mile = json['mile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    if (this.categories != null) {
      data['categories'] = this.categories?.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['rate'] = this.rate;
    data['available'] = this.available;
    data['mile'] = this.mile;
    return data;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arname'] = this.arname;
    data['enname'] = this.enname;
    data['deleted'] = this.deleted;
    data['suspensed'] = this.suspensed;
    data['created_at'] = this.createdAt;
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
  late int durationFrom;
  late int durationTo;
  late String durationUnit;
  late int offerDuration;
  late String offerDurationUnit;
  late int offerPrice;
  late int offerDiscount;
  late String images;
  late int km;
  late int familystatus;
  late int familyrate;

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category']??0;
    userId = json['user_id'];
    arname = json['arname'] ?? '';
    enname = json['enname'] ?? '';
    price = json['price'] ?? 0;
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['user_id'] = this.userId;
    data['arname'] = this.arname;
    data['enname'] = this.enname;
    data['price'] = this.price;
    data['duration_from'] = this.durationFrom;
    data['duration_to'] = this.durationTo;
    data['duration_unit'] = this.durationUnit;
    data['offer_duration'] = this.offerDuration;
    data['offer_duration_unit'] = this.offerDurationUnit;
    data['offer_price'] = this.offerPrice;
    data['offer_discount'] = this.offerDiscount;
    data['images'] = this.images;
    data['km'] = this.km;
    data['familystatus'] = this.familystatus;
    data['familyrate'] = this.familyrate;
    return data;
  }
}
