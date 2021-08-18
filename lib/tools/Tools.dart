import 'package:junior_test/resources/api/mall_api_provider.dart';

class Tools {
  static const int LIST_ITEM_COUNT = 5;

  static String getImagePath(String shortPath) {
    //TODO выдавать какую-нибудь картинку при пустом адресе.
    if ((shortPath == null) || (shortPath == "null")) {
      shortPath = "uploads/mall.jpg";
    }
    return MallApiProvider.baseImageUrl + shortPath;
  }
}
