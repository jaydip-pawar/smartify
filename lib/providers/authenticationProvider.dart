import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationProvider with ChangeNotifier {

  String email = '', country = '', password = '';
  String otp = '';

  FirebaseAuth _auth = FirebaseAuth.instance;

  signUpDetails(country, email, password) {
    this.country = country;
    this.email = email;
    this.password = password;
    notifyListeners();
  }

  Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'user not exist';
      } else if (e.code == 'wrong-password') {
        return 'wrong password';
      }
    } catch (e) {
      print(e);
      return 'error';
    }
    return 'Successful';
  }

  Future<String> signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Weak Password';
      }
    } catch (e) {
      print(e);
      return 'error';
    }
    return 'Successful';
  }

  Future<bool> checkUserExist(String email) async {
    await _auth.fetchSignInMethodsForEmail(email).then((value) {
      if(value.length == 0){
        return false;
      }
      else {
        return true;
      }
    });
    return false;
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