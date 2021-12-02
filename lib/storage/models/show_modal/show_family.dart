class ShowFamilyModal {
late DataFamily <Family> family;
late List <Familycategories> familycategories;
late DataFamily  <ProductsFamily> specialproducts;
late DataFamily <ProductsFamily> products;

  ShowFamilyModal.fromJson(Map<String, dynamic> json) {
    family = (json['family'] != null
        ? DataFamily<Family>.fromJson(json['family'])
        : null)!;
    if (json['familycategories'] != null) {
      familycategories = <Familycategories>[];
      json['familycategories'].forEach((v) {
        familycategories.add(new Familycategories.fromJson(v));
      });
    }
    // familycategories = (json['familycategories'] != null
    //     ? DataFamily<Familycategories>.fromJson(json['familycategories'])
    //     : null)!;
    products = (json['products'] != null
        ? DataFamily<ProductsFamily>.fromJson(json['products'])
        : null)!;
    specialproducts = (json['specialproducts'] != null
        ? DataFamily<ProductsFamily>.fromJson(json['specialproducts'])
        : null)!;
  }
}
class DataFamily<T> {
  late int currentPage;
  late List<T> data= [];
  late String? firstPageUrl;
  late int? from;
  late int? lastPage;
  late String? lastPageUrl;
  late String? nextPageUrl;
  late String? path;
  late int? perPage;
  late String? prevPageUrl;
  late int? to;
  late int? total;
  DataFamily();
  DataFamily.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page']??0;
    if (json['data'] != null) {
      data = <T>[];
      if (T == ProductsFamily) {
        json['data'].forEach((v) {
          data.add(ProductsFamily.fromJson(v) as T);
        });
      } else if (T == Family) {
        json['data'].forEach((v) {
          data.add(Family.fromJson(v) as T);
        });
      } else if (T == Familycategories) {
        json['data'].forEach((v) {
          data.add(Familycategories.fromJson(v) as T);
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

class Family {
 late int id;
 late String name;
 late String image;
 late String coverImage;
 late String notes;
 late String ennotes;
 late String minimumOrder;
 late int rate;
 late int available;
 late int km;
 late Policy policy;
 late List<Comments> comments;



  Family.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    coverImage = json['cover_image'];
    notes = json['notes'];
    ennotes = json['ennotes'];
    minimumOrder = json['minimum_order'];
    rate = json['rate'];
    available = json['available'];
    km = json['km'];
    policy =
    (json['policy'] != null ? new Policy.fromJson(json['policy']) : null)!;
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['cover_image'] = this.coverImage;
    data['notes'] = this.notes;
    data['ennotes'] = this.ennotes;
    data['minimum_order'] = this.minimumOrder;
    data['rate'] = this.rate;
    data['available'] = this.available;
    data['km'] = this.km;
    if (this.policy != null) {
      data['policy'] = this.policy.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Policy {
  late int id;
  late int userId;
  late String arpolicy;
  late String? enpolicy;
  late String createdAt;

  Policy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    arpolicy = json['arpolicy'];
    enpolicy = json['enpolicy'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['arpolicy'] = this.arpolicy;
    data['enpolicy'] = this.enpolicy;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Comments {
  late int id;
  late int userId;
  late int familyId;
  late int orderId;
  late String comment;
  late String rate;
  late String createdAt;
  late String username;

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    familyId = json['family_id'];
    orderId = json['order_id'];
    comment = json['comment']??'';
    rate = json['rate'];
    createdAt = json['created_at'];
    username = json['username'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['family_id'] = this.familyId;
    data['order_id'] = this.orderId;
    data['comment'] = this.comment;
    data['rate'] = this.rate;
    data['created_at'] = this.createdAt;
    data['username'] = this.username;
    return data;
  }
}

class Familycategories {
  late int id;
  late int userId;
  late String arname;
  late String enname;
  late int deleted;
  late String createdAt;

  Familycategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    arname = json['arname'];
    enname = json['enname'] ?? '';
    deleted = json['deleted'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['arname'] = this.arname;
    data['enname'] = this.enname;
    data['deleted'] = this.deleted;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ProductsFamily {
  late int id;
  late int userId;
  late String arname;
  late String enname;
  late int price;
  late int category;
  late int durationFrom;
  late int durationTo;
  late String durationUnit;
  late int offerPrice;
  late int offerDiscount;
  late String images;
  late int km;
  late String? familystatus;
  late int familyrate;

  ProductsFamily.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    arname = json['arname'];
    enname = json['enname'];
    price = json['price'];
    category = json['category'];
    durationFrom = json['duration_from'];
    durationTo = json['duration_to'];
    durationUnit = json['duration_unit'];
    offerPrice = json['offer_price'];
    offerDiscount = json['offer_discount'];
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
