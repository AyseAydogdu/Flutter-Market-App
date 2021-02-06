import 'package:http/http.dart' as http;

abstract class ProductApi {
  static Future getProducts() async {
    return await http.get(
        'https://raw.githubusercontent.com/AyseAydogdu/Dosyalar/master/product.json');
  }
}
