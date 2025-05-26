import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/product_card.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/views/cart_screen.dart';
import '../controllers/product_controller.dart';

class ProductListScreen extends StatelessWidget {
  final ProductController controller = Get.find();
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),

        actions: [
          Obx(() {
            // Total item count from cart
            int totalItems = cartController.cartItems.length;

            return InkWell(
              onTap: (){
                onPressed: () => Get.toNamed('/cart');
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () => Get.toNamed('/cart'),
                  ),
                  if (totalItems > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                        child: Text(
                          totalItems.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ],


      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              return ProductCard(product: controller.productList[index]);
            },
          );
        }
      }),
    );
  }

}