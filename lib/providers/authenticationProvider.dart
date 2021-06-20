import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationProvider with ChangeNotifier {

  String email = '', country = '', password = '';

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

  void signUp(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        //email exists
      }
    } catch (e) {
      print(e);
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    // await GoogleSignIn().disconnect();
    // await GoogleSignIn().signOut();
  }

}