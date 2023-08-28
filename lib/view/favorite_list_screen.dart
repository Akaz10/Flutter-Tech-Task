import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/controller/favorite_controller.dart';


// ignore: must_be_immutable
class FavoriteListScreen extends StatelessWidget {
  FavoriteListScreen({Key? key}) : super(key: key);
  var favs = Hive.box('favorites');
  final FavoriteController controller = Get.put(FavoriteController());
  @override
  Widget build(BuildContext context) {
    controller.setFavoriteList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Obx(() =>Text(controller.favoriteList.length.toString())),
      ),
      body: Obx(() =>ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.favoriteList.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.favoriteList[index]['name'],
                      style: const TextStyle(
                          fontSize: 22.0, color: Colors.black),
                    ),
                    IconButton(
                      onPressed: () => controller.deleteFavorite(index),
                      icon: const Icon(Icons.remove),
                    )
                  ],
                ),
              ),
            );
          })),
    );
  }
}
