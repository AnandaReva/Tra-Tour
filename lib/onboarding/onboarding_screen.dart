import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tratour/globalVar.dart';
import 'package:tratour/onboarding/intro_page_1.dart';
import 'package:tratour/onboarding/intro_page_2.dart';
import 'package:tratour/onboarding/intro_page_3.dart';
import 'package:tratour/pages/login_register_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key, required this.globalVar}) : super(key: key);

  final GlobalVar globalVar;

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //bool _roleSelected = false;

  final PageController _pageController = PageController(initialPage: 0);
  GlobalVar globalVar = GlobalVar.instance;

  int currentPage = 0;
  List<Widget> listPage = [];

  // Move initialization of listPage to initState
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round();
      });
    });

    // Initialize listPage here
    listPage = [
      IntroPage1(),
      IntroPage2(),
      IntroPage3(
        globalVar: widget.globalVar,
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
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
                        _pageController.jumpToPage(listPage.length - 1);
                      },
                    ),
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: listPage.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.white30,
                        activeDotColor: Colors.white,
                      ),
                    ),
                    onLastPage
                        ? (globalVar.selected_role_onboarding != null &&
                                globalVar.selected_role_onboarding.isNotEmpty)
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
                                  // Set userLoginData menjadi null atau kosong
                                  globalVar.userLoginData = null;
                                  globalVar.isLogin = false;

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(
                                        globalVar: globalVar,
                                      ),
                                    ),
                                  
                                  );
                                },
                              )
                            : SizedBox() // Tampilkan widget kosong jika peran belum dipilih

                        : GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: currentPage == 1
                                    ? Color.fromARGB(255, 29, 121, 72)
                                    : Color.fromARGB(255, 243, 183, 62),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              _pageController.nextPage(
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
