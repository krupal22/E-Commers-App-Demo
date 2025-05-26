import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../../data/services/product_service.dart';

class ProductController extends GetxController {
  final ProductService _service = ProductService();

  var isLoading = true.obs;
  var productList = <Product>[].obs;

  //For product List Screen
  Rx<Product?> product = Rx<Product?>(null);
  RxInt quantity = 1.obs;
  RxInt currentImageIndex = 0.obs;


  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    print("i am calll");
    try {
      isLoading(true);
      productList.value = await _service.fetchProducts();
    } finally {
      isLoading(false);
    }
  }


}