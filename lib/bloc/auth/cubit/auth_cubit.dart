 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
 import 'package:http/http.dart' as http;

import '../../../components/sanckbar.dart';
import '../../../components/shared/token.dart';
import '../state/auth_state.dart';




class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final TokenStorage _tokenStorage = TokenStorage();

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final url = Uri.parse('http://testflutter.aboodm.com/api/login');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['access_token'] != null) {
          final accessToken = data['access_token'];

          await _tokenStorage.saveToken(accessToken);

          showSnackbar("Success", data['message'] ?? "Login successful");
          emit(LoginSuccess());
        } else {
          showSnackbar("Error", 'Invalid response from server.', isError: true);
          emit(LoginFailure('Invalid response from server.'));
        }
      } else {
        showSnackbar("Error", 'Error: ${response.statusCode}, ${response.body}', isError: true);
        emit(LoginFailure('Error: ${response.statusCode}, ${response.body}'));
      }
    } catch (e) {
      showSnackbar("Error", e.toString(), isError: true);
      emit(LoginFailure(e.toString()));
    }
  }
}






class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    if (password != passwordConfirmation) {
      showSnackbar("Error", "Passwords do not match", isError: true);
      emit(RegisterFailure("Passwords do not match"));
      return;
    }

    emit(RegisterLoading());
    try {
      final response = await http.post(
        Uri.parse('http://testflutter.aboodm.com/api/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['message'] == "you register successfully") {
          showSnackbar("Success", data['message']);
          emit(RegisterSuccess());
        } else {
          showSnackbar("Error", data['message'] ?? 'Registration failed', isError: true);
          emit(RegisterFailure(data['message'] ?? 'Registration failed'));
        }
      } else {
        final data = json.decode(response.body);
        showSnackbar("Error", data['message'] ?? 'Failed to register, please try again later.', isError: true);
        emit(RegisterFailure(data['message'] ?? 'Failed to register, please try again later.'));
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: ${e.toString()}", isError: true);
      emit(RegisterFailure("An error occurred: ${e.toString()}"));
    }
  }
}



class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit()
      : super(EditProfileState(
    nameController: TextEditingController(),
    dateController: TextEditingController(),
    emailController: TextEditingController(),
    phoneController: TextEditingController(),
    gender: "male",
  ));

  final ImagePicker _picker = ImagePicker();

  // تغيير الجنس
  void changeGender(String newGender) {
    emit(state.copyWith(gender: newGender));
  }

  // اختيار صورة
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(pickedImage: image));
    }
  }

  // حفظ البيانات
  void saveData(BuildContext context) {
    if (state.nameController.text.isNotEmpty &&
        state.emailController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile saved successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields!")),
      );
    }
  }

  @override
  Future<void> close() {
    state.nameController.dispose();
    state.dateController.dispose();
    state.emailController.dispose();
    state.phoneController.dispose();
    return super.close();
  }
}

// State Class
class EditProfileState {
  final TextEditingController nameController;
  final TextEditingController dateController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final String gender;
  final XFile? pickedImage;

  EditProfileState({
    required this.nameController,
    required this.dateController,
    required this.emailController,
    required this.phoneController,
    required this.gender,
    this.pickedImage,
  });

  EditProfileState copyWith({
    TextEditingController? nameController,
    TextEditingController? dateController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
    String? gender,
    XFile? pickedImage,
  }) {
    return EditProfileState(
      nameController: nameController ?? this.nameController,
      dateController: dateController ?? this.dateController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      gender: gender ?? this.gender,
      pickedImage: pickedImage ?? this.pickedImage,
    );
  }
}

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  final TokenStorage _tokenStorage = TokenStorage();

  Future<void> logoutUser() async {
    emit(LogoutLoading());
    try {
      final token = await _tokenStorage.getToken();
      if (token == null) {
        emit(LogoutFailure('No token found, user might already be logged out.'));
        return;
      }

      final response = await http.post(
        Uri.parse('http://testflutter.aboodm.com/api/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
         await _tokenStorage.deleteToken();
        emit(LogoutSuccess());
      } else {
        final data = json.decode(response.body);
        emit(LogoutFailure(data['message'] ?? 'Logout failed.'));
      }
    } catch (e) {
      emit(LogoutFailure('An error occurred: ${e.toString()}'));
    }
  }
}