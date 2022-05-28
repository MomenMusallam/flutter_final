import 'package:eekie/components/component.dart';
import 'package:eekie/components/constance.dart';
import 'package:eekie/local/cache_helper.dart';
import 'package:eekie/provider/category_provider.dart';
import 'package:eekie/routes.dart';
import 'package:eekie/provider/auth_service.dart';
import 'package:eekie/provider/bottom_navigation_bar_provider.dart';
import 'package:eekie/provider/product_provider.dart';
import 'package:eekie/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  late String homePage;

  if (CacheHelper.getData(key: 'id') != '') {
    userId = await CacheHelper.getData(key: 'id');
  }

  dynamic isShowOnBoard = await CacheHelper.getData(key: 'onBoarding');

  if (isShowOnBoard == null) {
    homePage = 'onBoarding';
  } else if (userId == null) {
    homePage = 'signin';
  } else {
    homePage = 'main_layout';
  }
  runApp(MyApp(homePage: homePage));
  FlutterNativeSplash.remove();
}

Future initializeFunction(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 3));
}

class MyApp extends StatelessWidget {
  String homePage;

  MyApp({required this.homePage, Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
          create: (_) => AuthService.instance()..getUserData(),
        ),
        ChangeNotifierProvider<BottomNavigationBarProvider>(
          create: (_) => BottomNavigationBarProvider(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (_) => CategoryProvider()..getCategories(),
        ),
        ChangeNotifierProvider<ProductProvider>(
            create: (_) => ProductProvider()
              ..getFavorites()
              ..getOffers()
              ..getCart()),
      ],
      child: MaterialApp(
        initialRoute: homePage,
        onGenerateRoute: Routers.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Final Project',
        theme: theme,
        darkTheme: theme,
      ),
    );
  }
}
