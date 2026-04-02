import 'package:flutter/material.dart';
import '../data/models/product.dart';
import '../data/services/cart_service.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int quantity = 0;

  String formatRupiah(int number) {
    return "Rp ${number.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ".")}";
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // 🔥 IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                p.image ?? "",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 50),
              ),
            ),

            const SizedBox(width: 10),

            // 🔥 INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.productName ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatRupiah(p.price ?? 0),
                    style: const TextStyle(color: Colors.green),
                  ),
                  const SizedBox(height: 4),
                  Text("⭐ ${p.rating ?? 0}"),
                ],
              ),
            ),

            // 🔥 QUANTITY + CART
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (quantity > 0) {
                          setState(() => quantity--);
                        }
                      },
                    ),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => setState(() => quantity++),
                    ),
                  ],
                ),

                // 🔥 ADD TO CART BUTTON
                ElevatedButton(
                  onPressed: () {
                    if (quantity > 0) {
                      CartService().addToCart(widget.product, quantity);
                      setState(() => quantity = 0);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Ditambahkan ke keranjang"),
                        ),
                      );
                    }
                  },
                  child: const Text("Add to Cart"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
