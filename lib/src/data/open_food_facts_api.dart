import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenFoodFactsApi {
  OpenFoodFactsApi({http.Client? client}) : _client = client ?? http.Client();
  final http.Client _client;

  Future<Map<String, dynamic>> getProduct(String barcode) async {
    final uri = Uri.https(
      'world.openfoodfacts.org',
      '/api/v3/product/$barcode',
      {
        'fields': 'code,product_name,brands,image_front_small_url,nutrition_grades,ecoscore_grade,nova_group,ingredients_text,allergens_tags,nutriments,labels_tags',
      },
    );
    final response = await _client.get(
      uri,
      headers: const {
        'User-Agent': 'GoodFoodScan/0.1.0 (https://github.com/3115a083/Good-Food-Scan)',
      },
    );
    if (response.statusCode == 404) throw const ProductNotFoundException();
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Open Food Facts HTTP ${response.statusCode}');
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}

class ProductNotFoundException implements Exception {
  const ProductNotFoundException();
}
