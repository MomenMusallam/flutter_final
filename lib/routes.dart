import 'package:eekie/user/wrapper.dart';
import 'package:eekie/views/favorite_screen.dart';
import 'package:eekie/views/profile_screen.dart';
import 'package:eekie/user/onboarding_screen.dart';
import 'package:eekie/user/signin_screen.dart';
import 'package:eekie/user/signup_screen.dart';
import 'package:flutter/material.dart';
import 'layout/home_layout.dart';
import 'views/cart_screen.dart';
import 'views/home_screen.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'wrapper':
        return MaterialPageRoute(builder: (_) => const Wrapper());
      case 'signin':
        return MaterialPageRoute(builder: (_) =>  SigninScreen());
      case 'signup':
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case 'onBoarding':
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case 'main_layout':
        return MaterialPageRoute(builder: (_) => const MainLayout());
      case 'profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case 'favorite':
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());
      case 'cart':
        return MaterialPageRoute(builder: (_) => const CartScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
