class Cart {
   int? id;
   int? productId;
   String? productName;
   String? productImage;
   int? userId;
   int? qty;
   dynamic total;
   dynamic intialPrice;
   int? offerStatus;

  Cart(
      { this.id,
      this.productId,
      this.productName,
      this.productImage,
      this.userId,
      this.offerStatus,
      this.intialPrice,
      this.qty,
      this.total});

  Cart.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    productId = map['product_id'];
    productName = map['product_name'];
    productImage = map['product_image'];
    userId = map['user_id'];
    qty = map['qty'];
    total = map['total'];
    intialPrice = map['intial_price'];
    offerStatus = map['offer_status'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['product_image'] = productImage;
    map['user_id'] = userId;
    map['qty'] = qty;
    map['intial_price'] = intialPrice;
    map['offer_status'] = offerStatus;
    map['total'] = total;
    return map;
  }
}
