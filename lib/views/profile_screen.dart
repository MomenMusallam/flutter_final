import 'package:eekie/provider/auth_service.dart';
import 'package:eekie/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: authService.userModel != null
          ? WidgetBody(
              authService: authService,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class WidgetBody extends StatelessWidget {
  AuthService authService;

  WidgetBody({required this.authService, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(100.0),
                image: const DecorationImage(
                  image: NetworkImage(
                      "https://media.istockphoto.com/photos/stylish-man-posing-on-grey-background-picture-id973481674?b=1&k=20&m=973481674&s=170667a&w=0&h=N88rKUiC4M3YHGvanhxY5mMfVRsOSEKg9swrpwAnQQ0="),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: [
                  Text(
                    authService.userModel!.username.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    authService.userModel!.email.toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            actionItem(
                icon: "assets/images/cart.png",
                text: "Recent Adds",
                function: () {}),
            actionItem(
                icon: "assets/images/save.png",
                text: "Bookmarks",
                function: () {}),
            actionItem(
                icon: "assets/images/choices.png",
                text: "My Orders",
                function: () {}),
            actionItem(
                icon: "assets/images/purse.png",
                text: "Payment Methods",
                function: () {}),
            actionItem(
                icon: "assets/images/map.png",
                text: "Deliver Info",
                function: () {}),
            actionItem(
                icon: "assets/images/calendar.png",
                text: "Purchase History",
                function: () {}),
            actionItem(
                icon: "assets/images/settings.png",
                text: "Settings",
                function: () {}),
          ],
        ),
      ),
    );
  }

  Widget actionItem(
      {required Function function,
      required String icon,
      required String text}) {
    return InkWell(
      onTap: () => function(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(100.0),
                image: DecorationImage(
                  image: AssetImage(icon),
                  //  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward, size: 16),
          ],
        ),
      ),
    );
  }
}
