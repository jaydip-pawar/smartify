import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartify/providers/authenticationProvider.dart';

class OTPTimer extends StatefulWidget {
  const OTPTimer({Key? key}) : super(key: key);

  @override
  _OTPTimerState createState() => _OTPTimerState();
}

class _OTPTimerState extends State<OTPTimer> {

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

    final _authenticationProvider = Provider.of<AuthenticationProvider>(context);

    return RichText(
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
                _authenticationProvider.sendOTP();
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
    );
  }
}
