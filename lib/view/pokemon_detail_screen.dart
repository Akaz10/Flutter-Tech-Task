import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon/controller/pokemone_detail_controller.dart';

class PokemonDetailScreen extends StatelessWidget {
  final String url;

  const PokemonDetailScreen({required this.url, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(url);
    final PokemonDetailController controller =
        Get.put(PokemonDetailController());
    controller.fetchPokemonDetail(url);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 30,
            )),
      ),
      body: Obx(() => SafeArea(
            child: controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: Get.width,
                              height: Get.height,
                            ),
                            Positioned(
                                child: Container(
                              height: Get.height * 0.35,
                              width: Get.width,
                              child: Image.network(
                                controller
                                    .pokemonDetail.value.sprites!.frontDefault,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.amber,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Whoops!',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  );
                                },
                              ),
                            )),
                            Positioned(
                                top: Get.height * 0.35,
                                child: Container(
                                  width: Get.width,
                                  height: Get.height,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(38),
                                          topRight: Radius.circular(38))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Text(
                                          controller.pokemonDetail.value.name!,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                                        ),
                                      ),
                                      textType(
                                          title: 'Height: ',
                                          label: controller.pokemonDetail.value.height.toString()),
                                      textType(
                                          title: 'Weight: ',
                                          label: controller.pokemonDetail.value.weight.toString()),
                                      Padding(
                                          padding: EdgeInsets.all(14.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Ability: ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              ...List.generate(
                                                controller.pokemonDetail.value.abilities?.length ?? 0,
                                                (index) => Text("${controller.pokemonDetail.value.abilities![index].ability.name} ",
                                                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                                                ),
                                              )
                                            ],
                                          )),
                                      Padding(
                                        padding: EdgeInsets.all(14.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Stats : ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            ListView.builder(
                                                physics: const BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: controller.pokemonDetail.value.stats?.length ?? 0,
                                                itemBuilder: (context, index) {
                                                  return textType(
                                                    title: '${controller.pokemonDetail.value.stats![index].stat.name}: ',
                                                    label: controller.pokemonDetail.value.stats![index].baseStat.toString(),
                                                    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16),
                                                    fontSize: 14
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
          )),
    );
  }

  Padding textType(
      {required String title,
      required String label,
      padding = const EdgeInsets.all(14.0),
      double fontSize = 16}) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: fontSize, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          Text(
            label,
            style: TextStyle(fontSize: fontSize, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
