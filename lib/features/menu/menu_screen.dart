import 'package:flutter/material.dart';
import '../../../data/models/product.dart';
import '../../../data/services/product_service.dart';
import '../../widgets/product_item.dart';
import '../transaction/invoice_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final ProductService _service = ProductService();

  List<Product> products = [];
  List<Product> filtered = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final result = await _service.getProducts();

      setState(() {
        products = result;
        filtered = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Gagal ambil data produk")));
    }
  }

  void search(String text) {
    final result = products.where((p) {
      return (p.productName ?? "").toLowerCase().contains(text.toLowerCase());
    }).toList();

    setState(() => filtered = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: search,
              decoration: const InputDecoration(
                hintText: "Search...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : filtered.isEmpty
          ? const Center(child: Text("Produk kosong"))
          : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                return ProductItem(product: filtered[i]);
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: filtered.isEmpty
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const InvoiceScreen()),
                    );
                  },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Checkout", style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
