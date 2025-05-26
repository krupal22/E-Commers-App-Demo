import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/product_model.dart';
import '../modules/cart/controllers/cart_controller.dart';
import '../modules/product/views/product_detail_screen.dart';
import 'netwoek_image_with_loading.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final cartController = Get.find<CartController>();

  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailScreen(productId: product.id??0));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child:

                NetworkImageWithLoading(imagePath: product.thumbnail ?? '',fit: BoxFit.cover,

                  height: 80,
                    width: 80,
                )

              ),
              const SizedBox(width: 16),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${product.price?.toStringAsFixed(2) ?? '0.00'}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        const SizedBox(width: 4),
                        Text('${product.rating ?? 0.0}/5'),
                      ],
                    ),
                  ],
                ),
              ),

              // Add to Cart Button (icon style)
              IconButton(
                onPressed: () {
                  cartController.addToCart(product);
                  Get.snackbar(
                    "Added to Cart",
                    product.title ?? '',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 1),
                    backgroundColor: Colors.green.shade50,
                    colorText: Colors.green.shade900,
                    margin: const EdgeInsets.all(12),
                    borderRadius: 12,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    icon: const Icon(Icons.check_circle, color: Colors.green, size: 28),
                    snackStyle: SnackStyle.FLOATING,
                    isDismissible: true,
                  );
                },
                icon: Icon(Icons.add_shopping_cart),
                tooltip: 'Add to Cart',
              ),
            ],
          ),
        ),
      ),
    );
  }
}



