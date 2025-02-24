import 'package:flutter/material.dart';
import 'package:project/pages/auth/login/login_screen.dart';

import '../../components/buttom.dart';
import '../../components/style/color.dart';
import '../auth/signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // توزيع العناصر بين الأعلى والأسفل
          children: [
            const SizedBox(),

            const Center(
              child: Text(
                "Welcome!",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // الأزرار في الأسفل
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomButton(
                    color: AppColors.primaryColor,
                    colortext: AppColors.textButtonColor,           label: "Sign Up",
                     onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    colortext: Colors.teal,
                    color: Colors.grey.shade300,
                    label: "Log In",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
