import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationProvider with ChangeNotifier {

  String email = '', country = '', password = '';
  String otp = '';

  signUpDetails(country, email, password) {
    this.country = country;
    this.email = email;
    this.password = password;
    notifyListeners();
  }

  // void login(String email, String password, BuildContext context) async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       return showDialog(
  //           context: context,
  //           builder: (_) => CustomAlertDialog(
  //             title: 'Sign in',
  //             description:
  //             'Sorry, we cant\'t find an account with this email address. Please try again or create a new account.',
  //             bText: 'Try again',
  //           ));
  //     } else if (e.code == 'wrong-password') {
  //       return showDialog(
  //           context: context,
  //           builder: (_) => CustomAlertDialog(
  //             title: 'Incorrect Password',
  //             description: 'Your username or password is incorrect.',
  //             bText: 'Try again',
  //           ));
  //     }
  //   }
  // }

  Future<String> signUp(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Weak Password';
      } else if (e.code == 'email-already-in-use') {
        return 'Email Already Exist';
      }
    } catch (e) {
      print(e);
      return 'error';
    }
    return 'Successful';
  }

  Future<bool> sendOTP() async {
    EmailAuth.sessionName = 'Smartify';
    var res = await EmailAuth.sendOtp(receiverMail: email);
    if(!res) {
      return false;
    }
    return true;
  }

  Future<bool> verifyOTP(String otp) async {
    var res = EmailAuth.validate(receiverMail: email, userOTP: otp);
    if(!res) {
      return false;
    }
    return true;
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    // await GoogleSignIn().disconnect();
    // await GoogleSignIn().signOut();
  }

}