import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/pages/auth/signup/signup_screen.dart';
import 'package:project/pages/home/home_screen.dart';
import '../../../bloc/auth/cubit/auth_cubit.dart';
import '../../../bloc/auth/state/auth_state.dart';
import '../../../components/buttom.dart';
import '../../../components/field.dart';
import '../../../components/social.dart';
import '../../main/main_screen.dart';
import '../forget_password/forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>   MainScreen()),
                    );
                  } else if (state is LoginFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 50),
                      // Header section
                      const Center(
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Input fields section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomInputField(
                            title: "Name",
                            controller: emailController,
                          ),
                          const SizedBox(height: 20),
                          CustomInputField(
                            title: "Password",
                            isPassword: true,
                            controller: passwordController,
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),  // انتقل إلى شاشة أخرى بعد الـ OnBoarding
                                );
                              },
                              child: const Text(
                                "Forget Password ?",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.25),

                      // Login button
                      CustomButton(
                        colortext: Colors.white,
                        color: Colors.teal,
                        label: state is LoginLoading ? "Loading..." : "Log In",
                        onTap: () {

                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();
                          context.read<LoginCubit>().loginUser(email: email, password: password);
                        },
                      ),

                      const SizedBox(height: 20),

                      // Social login section
                      const Column(
                        children: [
                          Text(
                            "Or",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialButton(iconPath: 'assets/images/facebook.svg'),
                              SizedBox(width: 20),
                              SocialButton(iconPath: 'assets/images/google.svg'),
                              SizedBox(width: 20),
                              SocialButton(iconPath: 'assets/images/x.svg'),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // Sign-up section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don’t Have An Account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpScreen()),  // انتقل إلى شاشة أخرى بعد الـ OnBoarding
                              );
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
