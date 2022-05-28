import 'package:eekie/local/cache_helper.dart';
import 'package:eekie/provider/bottom_navigation_bar_provider.dart';
import 'package:eekie/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/component.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bottomNav =
        Provider.of<BottomNavigationBarProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(bottomNav.appBarTitle![bottomNav.currentIndex!]),
        actions: [
          if (bottomNav.currentIndex != 3)
            Row(
              children: [
                IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                IconButton(
                    icon: const Icon(Icons.notifications_none),
                    onPressed: () {}),
                cartIcon(context)
              ],
            ),
          if (bottomNav.currentIndex == 3)
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {

                CacheHelper.clearData(key: 'id').then(
                  (value) {
                    showAlertDialog(context, (){
                  Navigator.pushNamedAndRemoveUntil(context, "signin", (route) => false);
                    });
                  },
                );
              },
            ),
        ],
      ),
      body: bottomNav.screens[bottomNav.currentIndex!],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomNav.currentIndex!,
        items: bottomNav.navBarsItems!,
        onTap: (index) {
          bottomNav.onClickItemNavigation(index);
        },
      ),
    );
  }
  showAlertDialog(BuildContext context,Function function) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Logout"),
      onPressed:  () =>function(),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Logout"),
      content:const Text("are you sure logout from app"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
