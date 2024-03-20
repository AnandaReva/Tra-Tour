// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:native_onboarding/homepage.dart';
import 'package:native_onboarding/intro_page_1.dart';
import 'package:native_onboarding/intro_page_2.dart';
import 'package:native_onboarding/intro_page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();
  List<Widget> listPage = [
    IntroPage1(),
    IntroPage2(),
    IntroPage3(),
  ];
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == listPage.length - 1);
              });
            },
            children: listPage,
          ),

          // indicator
          Container(
            alignment: Alignment(0, 0.9),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        _controller.jumpToPage(listPage.length - 1);
                      },
                    ),
                    SmoothPageIndicator(
                      controller: _controller,
                      count: listPage.length,
                      effect: ExpandingDotsEffect(
                          dotColor: Colors.white30,
                          activeDotColor: Colors.white),
                    ),
                    onLastPage
                        ? GestureDetector(
                            child: Text(
                              "Done",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return HomePage();
                                  },
                                ),
                              );
                            },
                          )
                        : GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color.fromARGB(255, 243, 183, 62),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              _controller.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
