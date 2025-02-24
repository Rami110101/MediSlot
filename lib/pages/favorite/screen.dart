import 'package:flutter/material.dart';

import '../../components/style/color.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: const Center(
        child: Text('Your favorite items will appear here', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
