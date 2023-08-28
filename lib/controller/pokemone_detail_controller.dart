import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/model/pokemon_detail_model.dart';
import 'package:pokemon/service/pokemon_service.dart';

class PokemonDetailController extends GetxController {

  var pokemonDetail = Rx(PokemonDetail());
  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void fetchPokemonDetail(String url) async {
    try {
      isLoading(true);
      var response = await PokemonService.fetchPokemonDetail(url);
      if(response != null){
        print(response.name);
        pokemonDetail.value = response;
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
}