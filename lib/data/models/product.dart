class Product {
  String? id;
  String? image;
  int? price;
  String? productName;
  double? rating;
  int? stock;

  Product({
    this.id,
    this.image,
    this.price,
    this.productName,
    this.rating,
    this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json, String key) {
    return Product(
      id: key,
      image: json['image'],
      price: json['price'],
      productName: json['productName'],
      rating: (json['rating'] ?? 0).toDouble(),
      stock: json['stock'],
    );
  }
}
