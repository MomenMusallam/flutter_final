import 'package:eekie/local/cache_helper.dart';
import 'package:eekie/model/onboarding_model.dart';
import 'package:eekie/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components/component.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLastView = false;
    PageController pageController = PageController();

    List<OnBoardingModel> onBoard = [
      OnBoardingModel(
        image: 'assets/images/onboarding_1.png',
        description: 'Buy Anything !',
      ),
      OnBoardingModel(
        image: 'assets/images/onboarding_2.png',
        description: 'Exclusive Products !',
      ),
      OnBoardingModel(
        image: 'assets/images/onboarding_3.png',
        description: 'Amazing Discount !',
      ),
    ];
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(30.0),
          color: primaryColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex:10,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: pageController,
                    itemBuilder: (context, index) {
                      return buildPageViewItem(onBoard[index]);
                    },
                    itemCount: onBoard.length,
                    onPageChanged: (index) {
                      if (index == onBoard.length - 1) {
                        isLastView = true;
                      } else {
                        isLastView = false;
                      }
                    },
                  ),
                ),
                SmoothPageIndicator(
                  controller: pageController,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.white,
                    dotHeight: 10,
                    expansionFactor:3,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: onBoard.length,
                ),
                const Spacer(),
                Row(
                  children: [
                    action(context: context, text: ''),
                    const Spacer(),
                    action(context: context, text: 'Skip')
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget action({required BuildContext context, required String text}) {
    return TextButton(
      onPressed: () {
        CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
          Navigator.pushNamedAndRemoveUntil(
              context, "signin", (route) {
            return false;
          });
        });
      },
      child: Text(text.toUpperCase(), style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
    );
  }

  Widget buildPageViewItem(OnBoardingModel model) {
    return Column(
      children: [
        Image(
          image: AssetImage(model.image),
          width: 300.0,
          height: 300.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 100.0),
        Text(
          model.description,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900,color: Colors.white),
        ),
      ],
    );
  }
}
