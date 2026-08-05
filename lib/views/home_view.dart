import 'package:flutter/material.dart';
import 'package:store_app/views/taps/cart_tap.dart';
import 'package:store_app/views/taps/favorite_tap.dart';
import 'package:store_app/views/taps/home_tap.dart';
import 'package:store_app/views/taps/search_tap.dart';
import 'package:store_app/views/taps/user_data_tap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Widget> views = [
    HomeTap(),
    SearchTap(),
    CartTap(),
    FavoriteTap(),
    UserDataTap(),
  ];
  int _currentPageIndex = 0;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Store App",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: views[_currentPageIndex],

      // 4. Implement the NavigationBar
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index; // Update state to redraw the screen
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_checkout_outlined),
            selectedIcon: Icon(Icons.shopping_cart_checkout_outlined),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite_border),
            label: 'Favorite',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_pin),
            selectedIcon: Icon(Icons.person_pin),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
