import 'package:flutter/material.dart';

import '../../components/style/color.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: const Center(
        child: Text('No new notifications', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
