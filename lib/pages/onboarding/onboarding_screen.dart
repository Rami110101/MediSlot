import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/pages/welcome/welcome_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../components/buttom.dart';
import '../../components/style/color.dart'; // تأكد من إضافة هذه الحزمة في pubspec.yaml

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
   final PageController _controller = PageController();

   final List<Map<String, String>> _pages = [
    {
      "image": "assets/images/on1.svg",
      "title": "Online health check",
      "description": "Book the best doctor in various specialties"
    },
    {
      "image": "assets/images/on2.svg",
      "title": "Neat To You",
      "description": " schedule your visit at any time that suits you"
    },
  ];

  int _currentPage = 0; // متغير لتخزين الصفحة الحالية

  @override
  void initState() {
    super.initState();
    // إضافة مستمع لتغيير الصفحة
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page?.toInt() ?? 0; // تحديث الصفحة الحالية
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // التأكد من التخلص من الـ controller بعد استخدامه
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     SvgPicture.asset(
                      _pages[index]["image"]!,
                      width: 250,
                      height: 250,
                    ),
                    const SizedBox(height: 20),
                     Text(
                      _pages[index]["title"]!,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        _pages[index]["description"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,

                         ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SmoothPageIndicator(
              controller: _controller,
              count: _pages.length,
              effect: const WormEffect(
                dotColor: AppColors.secondaryColor,
                activeDotColor :AppColors.primaryColor,
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: CustomButton(
              label: _currentPage == _pages.length - 1 ? "Get Started" : "Next", // تحديد النص حسب الصفحة الحالية
              onTap: () {
                if (_currentPage == _pages.length - 1) {
                   Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const WelcomeScreen()),  // انتقل إلى شاشة أخرى بعد الـ OnBoarding
                  );
                } else {
                   _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }
              },
              color: AppColors.primaryColor, // لون الخلفية
              colortext: AppColors.textButtonColor,  // لون النص
            ),
          ),
        ],
      ),
    );
  }
}
