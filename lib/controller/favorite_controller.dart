import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteController extends GetxController {

  var favoriteList = [].obs;
  var isLoading = false.obs;
  var favs = Hive.box('favorites');

  @override
  void onInit() {
    super.onInit();
  }

  void setFavoriteList(){
    favoriteList.clear();
    favs.toMap().forEach((key, value) {
      favoriteList.add(value);
    });
    print(favoriteList);
  }

  void deleteFavorite(index) async {
    favoriteList.removeAt(index);
    await Hive.box('favorites').delete(index);
  }


}