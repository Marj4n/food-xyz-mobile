import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      "product": {
        "id": product.id,
        "productName": product.productName,
        "price": product.price,
        "image": product.image,
      },
      "quantity": quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product(
        id: json['product']['id'],
        productName: json['product']['productName'],
        price: json['product']['price'],
        image: json['product']['image'],
      ),
      quantity: json['quantity'],
    );
  }
}
