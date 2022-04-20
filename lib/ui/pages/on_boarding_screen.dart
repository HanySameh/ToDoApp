import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do/ui/theme.dart';
import 'package:to_do/ui/widgets/button.dart';

import '../../services/theme_services.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String subtitle;

  OnBoardingModel(
      {required this.image, required this.title, required this.subtitle});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var onBoardingController = PageController();
  bool isLast = false;
  bool onBoarding = false;
  List<OnBoardingModel> screens = [
    OnBoardingModel(
      image: 'images/onBoarding1.png',
      title: 'Cheklist Finished Task',
      subtitle:
          'if you completed your task,so you can view the result you work for each day.',
    ),
    OnBoardingModel(
      image: 'images/onBoarding2.png',
      title: 'Create Your Task',
      subtitle:
          'Create your task to make sure every task you have can completed on time.',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: TextButton(
              onPressed: () {
                BoardingServices().switchScreen(onBoarding);
              },
              child: Text(
                'SKIP',
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[400],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            SmoothPageIndicator(
              controller: onBoardingController,
              count: screens.length,
              effect: ExpandingDotsEffect(
                dotColor:
                    Get.isDarkMode ? Colors.grey[100]! : Colors.grey[300]!,
                activeDotColor: primaryClr,
                dotHeight: 10,
                expansionFactor: 4,
                dotWidth: 10,
                spacing: 5.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: PageView.builder(
                controller: onBoardingController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(screens[index], context),
                itemCount: screens.length,
                onPageChanged: (int index) {
                  if (index == screens.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    isLast = false;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            CustomButton(
              lable: 'Next',
              onTap: () {
                if (isLast) {
                  BoardingServices().switchScreen(onBoarding);
                } else {
                  onBoardingController.nextPage(
                    duration: const Duration(milliseconds: 750),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildBoardingItem(OnBoardingModel model, context) => Column(
      children: [
        Expanded(
          child: CircleAvatar(
            backgroundColor: Theme.of(context).backgroundColor,
            radius: 180.0,
            backgroundImage: AssetImage(model.image),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          model.title,
          style: headingStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          model.subtitle,
          style: subHeadingStyle.copyWith(
            fontSize: 15.0,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
