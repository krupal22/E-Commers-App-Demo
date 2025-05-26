import 'package:get/get.dart';
import '../modules/product/views/product_list_screen.dart';
import '../modules/product/bindings/product_binding.dart';
import '../modules/cart/views/cart_screen.dart';
import '../modules/cart/bindings/cart_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => ProductListScreen(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => CartScreen(),
      binding: CartBinding(),
    ),
  ];
}