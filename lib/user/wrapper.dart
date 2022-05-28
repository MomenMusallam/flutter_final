import 'package:eekie/components/constance.dart';
import 'package:eekie/layout/home_layout.dart';
import 'package:eekie/local/cache_helper.dart';
import 'package:eekie/provider/auth_service.dart';
import 'package:eekie/user/onboarding_screen.dart';
import 'package:eekie/user/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eekie/user/signin_screen.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => AuthService.instance(),
      child: Consumer(
        builder: (context, AuthService user, _) {
          switch (user.status) {
            case Status.uninitialized:
              return const OnBoardingScreen();
            case Status.unauthenticated:
            case Status.authenticating:
              return  SigninScreen();
            case Status.authenticated:
              return const MainLayout();
            case Status.creating:
            case Status.created:

              return  SigninScreen();
            case Status.uncreated:
              return const SignupScreen();
          }
        },
      ),
    );
  }
}
