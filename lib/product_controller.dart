import 'package:get/get.dart';
import 'apiservice.dart';
import 'product.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();

  // Reactive variables
  var products = <Product>[].obs;
  var isLoading = false.obs;
  var currentPage = 0.obs;
  final int pageSize = 30;

  Future<void> fetchProducts() async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final newProducts = await _productService.fetchProducts(
        currentPage: currentPage.value,
        pageSize: pageSize,
      );

      if (newProducts.isNotEmpty) {
        products.addAll(newProducts);
        currentPage.value++;
      } else {
        print("No more products to load.");
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}