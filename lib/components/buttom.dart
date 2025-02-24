import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
final Color color;
final Color colortext;
    CustomButton({
    Key? key,
    required this.label,
    required this.onTap,
      required this.color,
      required this.colortext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color:colortext,
              fontSize: 16,
              fontWeight: FontWeight.w700,

            ),
          ),
        ),
      ),
    );
  }
}
