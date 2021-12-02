class Cart {
   int? id;
   int? productId;
   String? productName;
   String? productImage;
   int? userId;
   int? quantity;
   int? price;

  Cart(
      { this.id,
      this.productId,
      this.productName,
      this.productImage,
      this.userId,
      this.quantity,
      this.price});

  Cart.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    productId = map['product_id'];
    productName = map['product_name'];
    productImage = map['product_image'];
    userId = map['user_id'];
    quantity = map['quantity'];
    price = map['price'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['product_image'] = productImage;
    map['user_id'] = userId;
    map['quantity'] = quantity;
    map['price'] = price;
    return map;
  }
}
