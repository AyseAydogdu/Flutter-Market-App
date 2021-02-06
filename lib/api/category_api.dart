import 'package:http/http.dart' as http;

class CategoryApi {
  static Future getCategories() async {
    return await http.get(
        'https://raw.githubusercontent.com/AyseAydogdu/Dosyalar/master/category.json');
  }
}
