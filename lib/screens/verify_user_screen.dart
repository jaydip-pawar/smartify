import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartify/providers/authenticationProvider.dart';
import 'package:smartify/screens/not_getting_code_screen.dart';
import 'package:smartify/widgets/otp_textfield.dart';

class VerifyUserScreen extends StatefulWidget {
  static const String id = 'verify-user-screen';
  const VerifyUserScreen({Key? key}) : super(key: key);

  @override
  _VerifyUserScreenState createState() => _VerifyUserScreenState();
}

class _VerifyUserScreenState extends State<VerifyUserScreen> {
  Key _inputKey = new GlobalKey(debugLabel: 'inputText');
  var _timer;
  int seconds = 59;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      print(seconds);
      setState(
        () {
          if (seconds == 0) {
            timer.cancel();
          } else {
            seconds = seconds - 1;
          }
        },
      );
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authenticationProvider =
        Provider.of<AuthenticationProvider>(context);

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
                child: OtpTextField(inputKey: _inputKey)),
            SizedBox(height: 50),
            RichText(
              text: TextSpan(
                text:
                    'A verification code has been sent to your email ${_authenticationProvider.email}  ',
                style: TextStyle(fontSize: 13, color: Colors.black54),
                children: [
                  seconds == 0
                      ? TextSpan(
                          text: 'Resend',
                          style: TextStyle(fontSize: 13, color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                seconds = 59;
                              });
                              startTimer();
                            },
                        )
                      : TextSpan(
                          text: 'Resend(${seconds}s)',
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                ],
              ),
            ),
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
