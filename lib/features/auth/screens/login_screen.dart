import 'package:flutter/material.dart';
import 'package:reddit_clone_flutter/core/constants/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // logo on appbar
      appBar: AppBar(
        title: Image.asset(
          Constants.logoPath,
          height: 40,
        ),
        centerTitle: true,
      ),
    );
  }
}
