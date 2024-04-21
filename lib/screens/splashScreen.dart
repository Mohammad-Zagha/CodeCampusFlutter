import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:getwidget/getwidget.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller; // For text animation
  late PageController _pageController; // For page sliding
  List<Widget> slideList = [];
  int initialPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Start the animation
    _controller.forward();

    _pageController = PageController(initialPage: initialPage);

    // To ensure the slideList is initialized after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return; // Check if the widget is still in the tree
      slideList = slides();
      setState(() {});
    });
  }
  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> slides() {
    return [
      Container(
        color: Color(0xFFFFFEFF),
        child: Stack(
          alignment: Alignment.center, // Center content within the stack
          children: [
            Positioned(
              top: 90,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'CODE',
                      style: TextStyle(
                        color: Colors.greenAccent[700],
                      ),
                    ),
                    TextSpan(
                      text: ' CAMPUS',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),),
            Lottie.asset("assets/splash3.json"), // This will be the base layer
            Positioned(
              bottom: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _controller,
                    child: Column(
                      children: [
                        Text(
                          'Welcome',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8), // Space between "Welcome" and the filler text
                        Text(
                          'Explore and Learn',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black.withOpacity(0.6), // Lighter filler text
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 16), // Space between the filler text and additional content
                        Text(
                          'Dive into a world where knowledge meets curiosity.\n Let your journey begin.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black.withOpacity(0.5), // Even lighter for additional filler text
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        color: Color(0xFF00AEFF),
        child: Stack(
          alignment: Alignment.center, // Center content within the stack
          children: [
            Positioned(
              top: 90,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Achive',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: ' and Earn',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),),
                   Lottie.asset("assets/splash4.json"), // This will be the base layer
            Positioned(
              bottom: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _controller,
                    child: Column(
                      children: [
                        Text(
                          'Embark on Your Learning Journey',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white, // Text color changed to white
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8), // Space between title and the filler text
                        Text(
                          'Unlock Knowledge, Earn Points',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white.withOpacity(0.8), // Lighter filler text, color changed to white
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 16), // Space between the filler text and additional content
                        Text(
                          'Every challenge you conquer, every quiz you ace,\n and every lesson you master fills your arsenal with points and achievements. Let each step forward celebrate your progress and unlock new worlds of understanding.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white.withOpacity(0.7), // Even lighter for additional filler text, color changed to white
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      Container(
        color: Color(0xFFF2C3E7),
        child: Stack(
          alignment: Alignment.center, // Center content within the stack
          children: [
            Positioned(
              top: 90,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Dive',
                      style: TextStyle(
                        color: Colors.pink,
                      ),
                    ),
                    TextSpan(
                      text: ' in creativity',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),),
         Lottie.asset("assets/splash6.json"), // This will be the base layer
            Positioned(
              bottom: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _controller,
                    child: Column(
                      children: [
                        Text(
                          'Plunge into the depths of innovation',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white, // Text color changed to white
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8), // Space between title and the filler text
                        Text(
                          'where ideas flourish and imagination\n knows no bounds.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white.withOpacity(0.8), // Lighter filler text, color changed to white
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 16), // Space between the filler text and additional content

                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GFIntroScreen(
        color: Colors.blueGrey,
        slides: slideList,
        pageController: _pageController,
        currentIndex: initialPage,
        pageCount: slideList.length,

        introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
          onDoneTap: () {
            Get.toNamed('/presingin');
          },
          onSkipTap: () {
            print("Skip");
            Get.toNamed('/presingin');
          },
          pageController: _pageController,
          pageCount: slideList.length,
          currentIndex: initialPage,
          onForwardButtonTap: () {
            _pageController.nextPage(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeIn);
          },
          onBackButtonTap: () {
            _pageController.previousPage(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeIn);
          },
          navigationBarColor: Colors.white,
          showDivider: false,
          inactiveColor: Colors.grey,
          activeColor: GFColors.SUCCESS,
        ),
      ),
    );
  }

}
