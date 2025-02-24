import 'package:flutter/material.dart';

import '../../components/style/color.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: const Center(
        child: Text('Your scheduled appointments will appear here', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
