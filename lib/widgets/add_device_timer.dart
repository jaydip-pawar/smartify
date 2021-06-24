import 'dart:async';

import 'package:flutter/material.dart';

class AddDeviceTimer extends StatefulWidget {
  const AddDeviceTimer({Key? key}) : super(key: key);

  @override
  _AddDeviceTimerState createState() => _AddDeviceTimerState();
}

class _AddDeviceTimerState extends State<AddDeviceTimer> {
  var _timer;
  int seconds = 59;
  int minutes = 1;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      print(seconds);
      setState(
        () {
          if (seconds == 0 && minutes == 0) {
            timer.cancel();
          } else if (seconds == 0) {
            minutes = minutes - 1;
            seconds = 59;
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
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '0$minutes:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          seconds <= 9
              ? Text(
                  '0$seconds',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                )
              : Text(
                  '$seconds',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
        ],
      ),
    );
  }
}
