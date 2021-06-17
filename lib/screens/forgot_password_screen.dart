import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String id = 'forgot-password-screen';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Forgot Password Screen"),
      ),
    );
  }
}
