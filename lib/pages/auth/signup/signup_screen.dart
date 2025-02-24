import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/pages/auth/login/login_screen.dart';
import '../../../bloc/auth/cubit/auth_cubit.dart';
import '../../../bloc/auth/state/auth_state.dart';
import '../../../components/buttom.dart';
import '../../../components/field.dart';
import '../../../components/social.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Registration Successful!')),
                    );
                  } else if (state is RegisterFailure) {
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
                      Center(
                        child: Text(
                          "Sign Up",
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
                            controller: nameController,
                          ),
                          const SizedBox(height: 20),
                          CustomInputField(
                            title: "Email",
                            controller: emailController,
                          ),
                          const SizedBox(height: 20),
                          CustomInputField(
                            title: "Password",
                            isPassword: true,
                            controller: passwordController,
                          ),
                          const SizedBox(height: 20),
                          CustomInputField(
                            title: "Confirm Password",
                            isPassword: true,
                            controller: confirmPasswordController,
                          ),
                        ],
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.10),

                      // Sign-up button
                      CustomButton(
                        colortext: Colors.white,
                        color: Colors.teal,
                        label: state is RegisterLoading ? "Loading..." : "Sign Up",
                        onTap: state is RegisterLoading
                            ? null
                            : () {
                          context.read<RegisterCubit>().registerUser(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            passwordConfirmation:
                            confirmPasswordController.text.trim(),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      // Social sign-up section
                      Column(
                        children: [
                          const Text(
                            "Or",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Row(
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

                      const SizedBox(height: 10),

                      // Log-in section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already Have An Account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),  // انتقل إلى شاشة أخرى بعد الـ OnBoarding
                              );                            },
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

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
