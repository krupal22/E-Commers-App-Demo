// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../data/models/product_model.dart';
// import '../../cart/controllers/cart_controller.dart';
//
// class ProductDetailScreen extends StatelessWidget {
//   final productController.Product productController.product;
//
//   ProductDetailScreen({required this.productController.product});
//
//   final CartController cartController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(productController.product.title??"")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(productController.product.thumbnail??"", height: 200),
//             SizedBox(height: 8),
//             Text(productController.product.description??""),
//             SizedBox(height: 8),
//             Text('Price: \$${productController.product.price}'),
//             Text('Rating: ${productController.product.rating}'),
//             Spacer(),
//             ElevatedButton(
//               onPressed: () => cartController.addToCart(productController.product),
//               child: Text('Add to Cart'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:e_commers_app_sample/widgets/netwoek_image_with_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../../data/services/product_service.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/product_controller.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  ProductDetailScreen({required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductService _service = ProductService();

  final CartController cartController = Get.find();
  final ProductController productController = Get.find();

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productController.product = Rx<Product?>(null);
    productController.quantity = 1.obs;
    productController.currentImageIndex = 0.obs;
  }

  void fetchProduct() async {
    try {
      final fetchedProduct =
          await _service.fetchProductDetail(widget.productId);
      productController.product.value = fetchedProduct;
      productController.quantity.value =
          fetchedProduct.minimumOrderQuantity ?? 1;
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Could not load product details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
            () => Text(productController.product.value?.title ?? 'Loading...')),
      ),
      body: Obx(() {
        if (productController.product.value == null) {
          return Center(child: CircularProgressIndicator());
        }
        final p = productController.product.value!;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: PageView.builder(
                  itemCount: p.images?.length ?? 1,
                  onPageChanged: (index) =>
                      productController.currentImageIndex.value = index,
                  itemBuilder: (context, index) {
                    return NetworkImageWithLoading(imagePath:  p.images != null && p.images!.isNotEmpty
                        ? p.images![index]
                        : p.thumbnail ?? '',
                    fit: BoxFit.contain);
                  },
                ),
              ),
              SizedBox(height: 8),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(p.images?.length ?? 1, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        width:
                            productController.currentImageIndex.value == index
                                ? 12
                                : 8,
                        height:
                            productController.currentImageIndex.value == index
                                ? 12
                                : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              productController.currentImageIndex.value == index
                                  ? Colors.blue
                                  : Colors.grey,
                        ),
                      );
                    }),
                  )),
              SizedBox(height: 16),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.title ?? '',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Category: ${p.category ?? '-'}',
                          style: TextStyle(color: Colors.grey[700])),
                      SizedBox(height: 8),
                      Text(p.description ?? ''),
                      SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Price: \$${p.price?.toStringAsFixed(2) ?? '0.00'}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              Text('Rating: ${p.rating?.toStringAsFixed(1) ?? '-'}',
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(width: 16),
                              Icon(Icons.star, color: Colors.amber),
                            ],
                          ),

                        ],
                      ),

                      SizedBox(height: 8),

                      //minimum qty
                      Text('Min Qty: ${p.minimumOrderQuantity ?? '1'}',
                          style: TextStyle(
                              fontSize: 16)),

                      SizedBox(height: 10),
                      // Quantity selector
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Quantity:', style: TextStyle(fontSize: 16)),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (productController.quantity.value >
                                        (productController.product.value
                                                    ?.minimumOrderQuantity ??
                                                1)
                                            .round())
                                      productController.quantity.value--;
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                                Obx(() => Text(
                                    productController.quantity.value.toString(),
                                    style: TextStyle(fontSize: 18))),
                                IconButton(
                                  onPressed: () {
                                    productController.quantity.value++;
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Add to Cart Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    cartController.addToCartWithQuantity(p, productController.quantity.value);
                    Get.snackbar(
                      'Added to Cart',
                      '${p.title} x${productController.quantity.value}',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: Duration(seconds: 1),
                    );
                  },
                  child: Text('Add to Cart')
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
