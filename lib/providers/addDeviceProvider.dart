import 'package:flutter/material.dart';

class AddDeviceProvider with ChangeNotifier {
  bool isTimerRunning = true;

  changeTimerState(bool status) {
    isTimerRunning = status;
    notifyListeners();
  }

  bool getTimerState() {
    return isTimerRunning;
  }
}