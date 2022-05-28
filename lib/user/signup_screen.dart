import 'package:eekie/components/component.dart';
import 'package:eekie/provider/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    final authService = Provider.of<AuthService>(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  logo(),
                  const SizedBox(height: 20.0),
                  const Text('Username', style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 5.0),
                  textInputField(
                    controller: usernameController,
                    keyboard: TextInputType.name,
                    hintText: 'Type your name',
                    context: context,
                  ),
                  const SizedBox(height: 15.0),
                  const Text('Mail', style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 5.0),
                  textInputField(
                    controller: emailController,
                    keyboard: TextInputType.emailAddress,
                    hintText: 'Type your email',
                    context: context,
                  ),
                  const SizedBox(height: 15.0),
                  const Text('Phone Number', style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 5.0),
                  textInputField(
                    controller: phoneController,
                    keyboard: TextInputType.phone,
                    hintText: 'Type your phone',
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
                  const SizedBox(height: 15.0),
                  const Text('Address', style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 5.0),
                  textInputField(
                    controller: addressController,
                    keyboard: TextInputType.streetAddress,
                    hintText: 'Type your address',
                    context: context,
                  ),
                  const SizedBox(height: 10.0),
                  // Text(
                  //   authService.error ?? "",
                  //   style: const TextStyle(
                  //     fontSize: 12,
                  //     color: Colors.red,
                  //   ),
                  // ),
                  const SizedBox(height: 30.0),
                  authService.status == Status.creating
                      ? const Center(child: CircularProgressIndicator())
                      : primaryButton(
                          text: 'Signup',
                          context: context,
                          function: () {
                            if (usernameController.text.isEmpty ||
                                passwordController.text.isEmpty ||
                                phoneController.text.isEmpty ||
                                emailController.text.isEmpty ||
                                addressController.text.isEmpty) {
                              toastMessage(message: "please fill field!");
                            } else {
                              authService
                                  .createUserWithEmailAndPassword(
                                email: emailController.text,
                                username: usernameController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                              )
                                  .then((value) {
                                if (value) {
                                  Navigator.pushNamed(context, "signin");
                                }
                              });
                            }
                          },
                        ),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, 'signin'),
                      child: const Text('SIGNIN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline)),
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
