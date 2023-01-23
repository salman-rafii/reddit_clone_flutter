import 'package:flutter/material.dart';
import 'package:reddit_clone_flutter/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final dynamic borderRadius;
  final double? fontSize;
  const CustomButton({
    super.key,
    required this.buttonText,
    this.backgroundColor,
    required this.onPressed,
    this.borderRadius,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: backgroundColor ?? Colors.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0.0))),
      child: CustomText(
        text: buttonText,
        fontSize: fontSize ?? 14.0,
      ),
    );
  }
}
