import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  var cartItems = <Product, int>{}.obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> stored = storage.read('cart') ?? {};
    cartItems.value = stored.map((key, value) =>
        MapEntry(Product.fromJson(Map<String, dynamic>.from(value['product'])), value['quantity']));
  }

  void addToCart(Product product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = product.minimumOrderQuantity??1;
    }
    saveCart();
  }

  void addToCartWithQuantity(Product product, int qty) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + qty;
    } else {
      cartItems[product] = qty;
    }
    update(); // notify listeners
  }


  void removeFromCart(Product product) {
    cartItems.remove(product);
    saveCart();
  }

  void changeQuantity(Product product, int quantity)
  {
    if (quantity <= 0) {
      cartItems.remove(product);
    } else {
      cartItems[product] = quantity;
    }
    saveCart();
  }

  void increaseQuantity(Product product) {
    if (cartItems.containsKey(product)) {
      print(cartItems[product].toString());
      cartItems[product] = cartItems[product]!+1;
      print(cartItems[product].toString());
      update();
    }

  }

  void decreaseQuantity(Product product) {
    if (cartItems.containsKey(product)) {
      if (cartItems[product]! > (product.minimumOrderQuantity??0).round()) {
        cartItems[product] = cartItems[product]!-1;
      } else {

        Get.snackbar(
          "product minimum qty is ${product.minimumOrderQuantity}",
          product.title ?? '',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red.shade50,
          colorText: Colors.red.shade900,
          margin: const EdgeInsets.all(12),
          borderRadius: 12,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          icon: const Icon(Icons.error_outline, color: Colors.red, size: 28),
          snackStyle: SnackStyle.FLOATING,
          isDismissible: true,
        );

      }
      update();
    }
  }



  double get totalPrice => cartItems.entries
      .map((e) => (e.key.price??0) * e.value)
      .fold(0.0, (prev, element) => prev + element);

  void clearCart() {
    cartItems.clear();
    storage.remove('cart');
  }

  void saveCart() {
    storage.write(
        'cart',
        cartItems.map((key, value) => MapEntry(key.id.toString(), {
          'product': {
            'id': key.id,
            'title': key.title,
            'description': key.description,
            'category': key.category,
            'price': key.price,
            'rating': key.rating,
            'stock': key.stock,
            'images': key.images,
            'thumbnail': key.thumbnail
          },
          'quantity': value
        })));
  }
}
