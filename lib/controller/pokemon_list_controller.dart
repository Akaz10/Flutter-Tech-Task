import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/model/pokemon_list_model.dart';
import 'package:pokemon/service/pokemon_service.dart';

class PokemonListController extends GetxController {
  var pokemonList = <Result>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchPokemonList();
    // TODO: implement onInit
    super.onInit();
  }

  void fetchPokemonList() async {
    try {
      isLoading(true);
      var response = await PokemonService.fetchPokemonList();
      if(response != null){
        pokemonList.value = response.results;
      }else{
        Get.snackbar("Warning",
            '',
            icon: const Icon(Icons.warning, color: Colors.white),
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3));
      }
      isLoading(false);
    }
    catch (err) {
      Get.snackbar("Warning",
          '$err',
          icon: const Icon(Icons.warning, color: Colors.white),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3));
      print(err);
      isLoading(false);
    }
  }

  void onFavoritePress(int index) {
    if (Hive.box('favorites').containsKey(index)) {
      Hive.box('favorites').delete(index);
      return;
    }
    Hive.box('favorites').put(index, {'name': pokemonList[index].name ,'url' : pokemonList[index].url});
  }

  Widget getIcon(int index) {
    if (Hive.box('favorites').containsKey(index)) {
      return Icon(Icons.favorite, color: Colors.red);
    }
    return Icon(Icons.favorite_border);
  }
}