import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/controller/pokemon_list_controller.dart';
import 'package:pokemon/view/pokemon_detail_screen.dart';


class PokemonListScreen extends StatelessWidget {
  PokemonListScreen({Key? key}) : super(key: key);

  final PokemonListController controller = Get.put(PokemonListController());

  @override
  Widget build(BuildContext context) {
    //Hive.box('favorites').clear();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Pokemon'),
      ),
      body: Obx(() => SafeArea(
          child: controller.pokemonList.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Colors.red,))
          : Padding(
            padding: const EdgeInsets.all(10),
            child: ListenableBuilder(
                listenable: Hive.box('favorites').listenable(),
                builder: (context, box,) {
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.pokemonList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Get.to(PokemonDetailScreen(url: controller.pokemonList[index].url,)),
                          child: Card(
                            margin: EdgeInsets.only(bottom: 12),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.pokemonList[index].name,
                                    style: const TextStyle(fontSize: 22.0,color: Colors.black),
                                  ),
                                  IconButton(
                                      onPressed: () => controller.onFavoritePress(index),
                                      icon: controller.getIcon(index),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } )
          ),)),
    );
  }
}
