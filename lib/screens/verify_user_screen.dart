import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartify/providers/authenticationProvider.dart';
import 'package:smartify/screens/not_getting_code_screen.dart';
import 'package:smartify/widgets/otp_textfield.dart';
import 'package:smartify/widgets/otp_timer.dart';

class VerifyUserScreen extends StatefulWidget {
  static const String id = 'verify-user-screen';
  const VerifyUserScreen({Key? key}) : super(key: key);

  @override
  _VerifyUserScreenState createState() => _VerifyUserScreenState();
}

class _VerifyUserScreenState extends State<VerifyUserScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.only(left: 35, right: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Text(
              'Enter Verification Code',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            SizedBox(height: 50),
            Container(
                width: double.infinity,
                child: OtpTextField()),
            SizedBox(height: 50),
            OTPTimer(),
            SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, NotGetCode.id);
              },
              child: Text(
                "Didn't get a code?",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}