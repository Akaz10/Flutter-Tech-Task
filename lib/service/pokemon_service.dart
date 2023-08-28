import 'package:dio/dio.dart';
import 'package:pokemon/model/pokemon_detail_model.dart';
import 'package:pokemon/model/pokemon_list_model.dart';


class PokemonService {
  static var dio = Dio();

  static fetchPokemonList() async {
    Response response;
    response = await dio.get('https://pokeapi.co/api/v2/pokemon');
    if(response.statusCode == 200){
      var jsonString = response.data;
      return pokemonListFromJson(jsonString);
    }
    else {
      return null;
    }
  }


  static fetchPokemonDetail(String url) async {
    Response response;
    response = await dio.get(url);
    if(response.statusCode == 200){
      var jsonString = response.data;
      return pokemonDetailFromJson(jsonString);
    }
    else {
      return null;
    }
  }



}