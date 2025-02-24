import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/cubit/auth_cubit.dart';
import '../../components/buttom.dart';
import '../../components/field.dart';
import '../../components/style/color.dart';
import '../main/main_screen.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>   MainScreen()),
              );
            },
          ),

          title: const Text("Edit Profile"),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: BlocBuilder<EditProfileCubit, EditProfileState>(
              builder: (context, state) {
                final cubit = context.read<EditProfileCubit>();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: state.pickedImage == null
                                ? const NetworkImage(
                                'https://via.placeholder.com/150')
                                : FileImage(File(state.pickedImage!.path))
                            as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.teal,
                              radius: 16,
                              child: IconButton(
                                onPressed: cubit.pickImage,
                                icon: const Icon(Icons.add,
                                    size: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomInputField(
                      title: "Edit Name",
                      controller: state.nameController,
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      title: "Date of Birth",
                      controller: state.dateController,
                      isDateField: true,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: RadioListTile<String>(
                              value: "male",
                              groupValue: state.gender,
                              activeColor: AppColors.primaryColor,
                              title: const Text("Male"),
                              onChanged: (value) {
                                cubit.changeGender(value!);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: RadioListTile<String>(
                              value: "female",
                              groupValue: state.gender,
                              activeColor: AppColors.primaryColor,
                              title: const Text("Female"),
                              onChanged: (value) {
                                cubit.changeGender(value!);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      title: "Edit Email",
                      controller: state.emailController,
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      title: "Phone Number",
                      controller: state.phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 32),
                    CustomButton(
                      color: AppColors.primaryColor,
                      colortext: AppColors.textButtonColor,
                      label: "Save",
                      onTap: () => cubit.saveData(context),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}