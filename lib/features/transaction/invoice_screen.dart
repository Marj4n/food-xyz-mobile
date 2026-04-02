import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/services/cart_service.dart';
import 'package:gal/gal.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final cartService = CartService();
  final ScreenshotController screenshotController = ScreenshotController();

  bool isFlash = false;

  String formatRupiah(int number) {
    return "Rp ${number.toString().replaceAllMapped(RegExp(r'\\B(?=(\\d{3})+(?!\\d))'), (match) => ".")}";
  }

  Future<void> saveToGallery() async {
    setState(() => isFlash = true);

    final image = await screenshotController.capture();

    await Future.delayed(const Duration(milliseconds: 200));
    setState(() => isFlash = false);

    if (image == null) return;

    await Gal.putImageBytes(
      image,
      name: "invoice_${DateTime.now().millisecondsSinceEpoch}.png",
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Berhasil disimpan ke gallery")),
    );
  }

  Future<void> shareImage() async {
    final image = await screenshotController.capture();

    if (image == null) return;

    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/invoice.png');

    await file.writeAsBytes(image);

    await Share.shareXFiles([XFile(file.path)], text: "Invoice Belanja");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Invoice")),

      body: Stack(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Container(
              color: Colors.white,
              child: ValueListenableBuilder(
                valueListenable: cartService.cart,
                builder: (_, cart, __) {
                  if (cart.isEmpty) {
                    return const Center(child: Text("Keranjang kosong"));
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: cart.length,
                          itemBuilder: (_, i) {
                            final item = cart[i];
                            final subtotal =
                                (item.product.price ?? 0) * item.quantity;

                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              child: ListTile(
                                leading: Image.network(
                                  item.product.image ?? "",
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.image),
                                ),
                                title: Text(item.product.productName ?? ""),
                                subtitle: Text(
                                  "${item.quantity} x ${formatRupiah(item.product.price ?? 0)}",
                                ),
                                trailing: Text(formatRupiah(subtotal)),
                              ),
                            );
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          "Total: ${formatRupiah(cartService.total)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: saveToGallery,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                child: const Text("Save ke Gallery"),
                              ),
                            ),

                            const SizedBox(height: 8),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: shareImage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: const Text("Share Gambar"),
                              ),
                            ),

                            const SizedBox(height: 8),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  cartService.clearCart();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Terima kasih telah berbelanja",
                                      ),
                                    ),
                                  );

                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text("Selesai"),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ),

          if (isFlash) Container(color: Colors.white.withOpacity(0.8)),
        ],
      ),
    );
  }
}
