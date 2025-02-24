import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  final String iconPath;

  const SocialButton({required this.iconPath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       },
      child: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(
          iconPath,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
