import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:project/pages/main/main_screen.dart';
import 'package:project/pages/splash/spalsh_screen.dart';

import 'components/shared/token.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project Final',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: FutureBuilder<String?>(
        future: TokenStorage().getToken(),
        builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              return MainScreen();
            } else {
              return SplashScreen();
            }
          }
           return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
