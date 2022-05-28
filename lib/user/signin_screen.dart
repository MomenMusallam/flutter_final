import 'package:eekie/components/component.dart';
import 'package:eekie/components/constance.dart';
import 'package:eekie/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:eekie/provider/auth_service.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthService>(context, listen: true);
    var formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  logo(),
                  const SizedBox(height: 20.0),
                  const Text('Mail', style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 5.0),
                  textInputField(
                    controller: emailController,
                    keyboard: TextInputType.emailAddress,
                    hintText: 'Type your email',
                    context: context,
                  ),
                  const SizedBox(height: 15.0),
                  const Text('Password', style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 5.0),
                  textInputField(
                    controller: passwordController,
                    keyboard: TextInputType.visiblePassword,
                    hintText: 'Type your password',
                    context: context,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    authService.error ?? "",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  authService.status == Status.authenticating
                      ? const Center(child: CircularProgressIndicator())
                      : primaryButton(
                          text: 'Login',
                          context: context,
                          function: () {
                            authService
                                .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            )
                                .then((value) {
                              if (value) {
                                authService.getUserData();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  "main_layout",
                                  (route) => false,
                                );
                              }
                            });
                          },
                        ),
                  const SizedBox(height: 10.0),
                  Center(
                    child: Column(
                      children: [
                        textButton(
                            context: context,
                            text: 'Forget Password',
                            function: () {}),
                        textButton(
                            context: context,
                            text: 'SIGNUP',
                            function: () {
                              Navigator.pushNamed(context, 'signup');
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

TextButton textButton({
  required BuildContext context,
  required String text,
  required Function function,
}) {
  return TextButton(
    onPressed: () => function(),
    child: Text(text,
        style: const TextStyle(
            fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
  );
}
