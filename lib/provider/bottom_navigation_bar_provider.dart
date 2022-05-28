import 'package:eekie/views/cart_screen.dart';
import 'package:eekie/views/favorite_screen.dart';
import 'package:eekie/views/home_screen.dart';
import 'package:eekie/views/profile_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  List<Widget> screens = [
    const HomeScreen(),
    const CartScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  int _currentIndex = 0;

  int? get currentIndex => _currentIndex;
  List<String>? get appBarTitle => _appBarTitle;

  List<BottomNavigationBarItem>? get navBarsItems => _navBarsItems;

  final List<String> _appBarTitle = ['Home', 'Cart', 'Favorite', 'Profile'];

  final List<BottomNavigationBarItem> _navBarsItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      label: "Cart",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border),
      label: "Favorite",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      label: "Profile",
    ),
  ];

  void onClickItemNavigation(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
