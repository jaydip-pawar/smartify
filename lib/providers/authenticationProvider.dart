import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationProvider with ChangeNotifier {

  String email = '', country = '', password = '';
  String otp = '';

  FirebaseAuth _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;

  signUpDetails(country, email, password) {
    this.country = country;
    this.email = email;
    this.password = password;
    notifyListeners();
  }

  loginDetails(country, email, password) {
    this.country = country;
    this.email = email;
    this.password = password;
    notifyListeners();
  }

  Future<String> login() async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'Successful';
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
    return '';
  }

  Future<String> signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return 'Successful';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Weak Password';
      }
    } catch (e) {
      print(e);
      return 'error';
    }
    return '';
  }

  Future<bool> checkUserExist(String email) async => await _auth.fetchSignInMethodsForEmail(email).then((value) {
      print('list: $value');
      if(value.length == 0){
        return false;
      }
      else {
        return true;
      }
    });

  void addSignupData(String uid) {
    firestoreInstance.collection("user").doc(uid).set({
      "email": email,
      "country": country,
    }).then((_) {
      print("successfully added profile data!");
    });
  }

  Future<bool> sendOTP() async {
    var res = await EmailAuth(sessionName: "Smartify").sendOtp(recipientMail: email);
    if(!res) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> verifyOTP(String otp) async {
    var res = EmailAuth(sessionName: "Smartify").validateOtp(recipientMail: email, userOtp: otp);
    if(!res) {
      return false;
    } else {
      return true;
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    // await GoogleSignIn().disconnect();
    // await GoogleSignIn().signOut();
  }

}