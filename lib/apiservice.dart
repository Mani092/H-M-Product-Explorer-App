import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product.dart';

class ProductService {
  static const String apiUrl =
      "https://apidojo-hm-hennes-mauritz-v1.p.rapidapi.com/products/list";
  static const String apiKey = "eb460e5029msh68e7465aa418ce7p1c87abjsne2dbc2612e61"; // Replace with your API key
  static const String apiHost = "apidojo-hm-hennes-mauritz-v1.p.rapidapi.com";

  Future<List<Product>> fetchProducts({int currentPage = 0, int pageSize = 30}) async {
    try {
      final uri = Uri.parse(
        "$apiUrl"
            "?country=us"
            "&lang=en"
            "&currentpage=$currentPage"
            "&pagesize=$pageSize"
            "&categories=ladies_newarrivals_all%3Amena_all"
            "&concepts=H%26M+MAN",
      );

      final response = await http.get(
        uri,
        headers: {
          'X-RapidAPI-Key': apiKey,
          'X-RapidAPI-Host': apiHost,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('results')) {
          final List<dynamic> results = jsonData['results'];

          return results.map((item) {
            return Product(
              id: item['productId'] ?? '',
              name: item['name'] ?? 'No Name',
              price: item['price']?['value']?.toDouble() ?? 0.0,
              imageUrl: (item['images'] != null && item['images'].isNotEmpty)
                  ? item['images'][0]['url']
                  : '',
            );
          }).toList();
        } else {
          print("No 'results' found in API response.");
          return [];
        }
      } else {
        print("Error: ${response.statusCode}");
        print("Response: ${response.body}");
        return [];
      }
    } catch (e) {
      print("Exception occurred: $e");
      return [];
    }
  }
}