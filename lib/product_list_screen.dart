import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductListScreen extends StatelessWidget {
  final ProductController _controller = Get.put(ProductController());

  ProductListScreen() {
    _controller.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("H&M Product Explorer"),
        backgroundColor: Colors.pink,
      ),
      body: Obx(() => _controller.products.isEmpty && _controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!_controller.isLoading.value &&
              scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
            _controller.fetchProducts(); // Load next page
          }
          return false;
        },
        child: GridView.builder(
          padding: EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7,
          ),
          itemCount: _controller.products.length,
          itemBuilder: (context, index) {
            final product = _controller.products[index];
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "\$${product.price.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      )),
    );
  }
}