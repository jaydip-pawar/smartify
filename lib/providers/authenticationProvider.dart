import 'package:flutter/cupertino.dart';

class AuthenticationProvider with ChangeNotifier {

  String email = '', country = '';

  signUpDetails(country, email) {
    this.country = country;
    this.email = email;
    notifyListeners();
  }

}