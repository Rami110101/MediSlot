import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../components/buttom.dart';
import '../../../components/field.dart';
import '../../../components/style/color.dart';
import '../login/login_screen.dart';

 class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double verticalPadding = screenHeight * 0.05;
    double horizontalPadding = screenWidth * 0.04;
    double textSize = screenWidth * 0.08;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: verticalPadding),
                 Center(
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: verticalPadding *  5),
                // حقل البريد الإلكتروني
                CustomInputField(
                  title: "Enter Email Address",
                  keyboardType: TextInputType.emailAddress, // كيبورد البريد الإلكتروني

                  controller: emailController,
                ),
                SizedBox(height: verticalPadding *  5),
                // زر إرسال
                CustomButton(
                  color: AppColors.primaryColor, // لون الخلفية
                  colortext: AppColors.textButtonColor,  // لون النص
                  label: "Send OTP",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OTPPage()),
                    );
                  },
                ),
                SizedBox(height: verticalPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class OTPPage extends StatefulWidget {
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> with SingleTickerProviderStateMixin {
   String code = "";

   bool hasError = false;

   late AnimationController _controller;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticIn),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // وظيفة لإعادة إرسال الرمز
  void resendOTP() {
    setState(() {
      // إعادة إرسال الرمز
      print("Resending OTP...");
    });
  }

  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

     double verticalPadding = screenHeight * 0.05;
    double horizontalPadding = screenWidth * 0.04;
    double textSize = screenWidth * 0.08;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: verticalPadding),
                 Center(
                  child: Text(
                    "Verification",
                    style: TextStyle(
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: verticalPadding *5),
                const Center(
                  child: Text(
                    "Enter Verification Code",
                    style: TextStyle(
                      fontSize: 16,
                     ),
                  ),
                ),
                const SizedBox(height: 10,),
                // حقل إدخال OTP
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      margin: EdgeInsets.only(right: 20,left: 20,top: 20  ),
                       width: 300,
                      child: AnimatedBuilder(
                        animation: _shakeAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(_shakeAnimation.value, 0),
                            child: PinCodeTextField(
                              length: 4,
                              onChanged: (value) {
                                code = value;
                              },
                              onCompleted: (value) {
                                setState(() {
                                  code = value;
                                });
                                // عند اكتمال الرمز
                                if (code.length == 4) {
                                  // هنا يمكنك تنفيذ العملية عند اكتمال OTP
                                  print("OTP Verified");
                                } else {
                                  _controller.forward();
                                  setState(() {
                                    hasError = true;
                                  });
                                }
                              },
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(16),
                                fieldWidth: 49.75,
                                activeColor: AppColors.primaryColor,
                                inactiveColor: AppColors.secondaryColor,
                                selectedColor: AppColors.textGrayColor,
                                activeFillColor: Colors.teal.withOpacity(0.1),
                                inactiveFillColor: Colors.grey[200]!,
                                selectedFillColor: Colors.blue.withOpacity(0.1),
                              ),
                              cursorHeight: 12,
                              appContext: context,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(height: verticalPadding * 0.3),
                // زر إعادة إرسال OTP
                Center(
                  child: TextButton(
                    onPressed: resendOTP,  // استدعاء الدالة عند النقر
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: "If You Didn't Receive A Code. ",
                            style: TextStyle(
                               color: Colors.grey, // اللون الأساسي للنص
                            ),
                          ),
                          TextSpan(
                            text: "Resend", // الكلمة التي تريد تغيير لونها
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.teal, // اللون المختلف لكلمة "Resend"
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = resendOTP, // عند النقر على "Resend"، سيتم تنفيذ الدالة
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: verticalPadding * 4),
                 CustomButton(
                  colortext: Colors.white,
                  color: Colors.teal,
                  label: "Enter Code",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EnterNewPasswordScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


 class EnterNewPasswordScreen extends StatelessWidget {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double verticalPadding = screenHeight * 0.05;
    double horizontalPadding = screenWidth * 0.04;
    double textSize = screenWidth * 0.08;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: verticalPadding),
                // العنوان الرئيسي
                Center(
                  child: Text(
                    "Enter New Password",
                    style: TextStyle(
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: verticalPadding * 3),

                 CustomInputField(
                  title: "New Password",
                  controller: newPasswordController,
                  isPassword: true,
                ),
                SizedBox(height: verticalPadding * 0.5),

                 CustomInputField(
                  title: "Confirm Password",
                  controller: confirmPasswordController,
                  isPassword: true,
                ),

                 SizedBox(height: verticalPadding*5),

                 CustomButton(
                  colortext: Colors.white,
                  color: Colors.teal,
                  label: "Submit",
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
                SizedBox(height: verticalPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
