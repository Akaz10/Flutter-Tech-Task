import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon/view/favorite_list_screen.dart';
import 'package:pokemon/view/pokemon_list_screen.dart';

// ignore: must_be_immutable
class MyNavigationBarPage extends StatelessWidget {
  MyNavigationBarPage({Key? key}) : super(key: key);

  var _selectedIndex = 0.obs;

  static final List<Widget> _widgetOptions = <Widget>[
    PokemonListScreen(),
    FavoriteListScreen()
  ];

  void _onItemTapped(int index) {
      _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex.value),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label:'Home',
                backgroundColor: Colors.red
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
                backgroundColor: Colors.orange
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex.value,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5
      ),
    ));
  }
}
