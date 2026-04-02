import 'package:flutter/material.dart';
import '../../data/models/cart_item.dart';
import '../../data/models/product.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;

  CartService._internal();

  final ValueNotifier<List<CartItem>> cart = ValueNotifier([]);

  void addToCart(Product product, int qty) {
    final existing = cart.value.where((e) => e.product.id == product.id);

    if (existing.isNotEmpty) {
      existing.first.quantity += qty;
    } else {
      cart.value.add(CartItem(product: product, quantity: qty));
    }

    cart.notifyListeners();
  }

  void clearCart() {
    cart.value = [];
  }

  int get total {
    return cart.value.fold(
      0,
      (sum, item) => sum + (item.product.price ?? 0) * item.quantity,
    );
  }
}
