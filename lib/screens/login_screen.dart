import 'dart:core';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smartify/providers/authenticationProvider.dart';
import 'package:smartify/screens/forgot_password_screen.dart';
import 'package:smartify/screens/home_screen.dart';
import 'package:smartify/screens/select_country_screen.dart';
import 'package:smartify/widgets/custom_icon.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  String country = 'India';

  bool _passwordFocused = false;
  bool _emailFocused = false;
  bool visible = false;
  bool isEmailValid = false;
  bool userNotExist = false;
  bool loginFailed = false;
  bool error = false;
  bool loading = false;
  FocusNode _passwordFocus = new FocusNode();
  FocusNode _emailFocus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(_onEmailFocusChange);
    _passwordFocus.addListener(_onPasswordFocusChange);
  }

  @override
  Widget build(BuildContext context) {

    final _authenticationProvider = Provider.of<AuthenticationProvider>(context);

    void login() {
      setState(() {
        userNotExist = false;
        loginFailed = false;
        error = false;
        loading = true;
      });

      _authenticationProvider.loginDetails(country, _emailController.text, _passwordController.text);

      _authenticationProvider.login().then((value) {
        if(value == 'Successful') {
          setState(() {
            loading = false;
          });
          Navigator.pushReplacementNamed(context, HomeScreen.id);
        } else if(value == 'user not exist') {
          setState(() {
            userNotExist = true;
            loading = false;
          });
        } else if(value == 'wrong password') {
          setState(() {
            loginFailed = true;
            loading = false;
          });
        } else if(value == 'error'){
          setState(() {
            error = true;
            loading = false;
          });
        }
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            SizedBox(
              height: 15,
            ),
            Text(
              'Log In',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              onTap: () {
                getCountry();
              },
              readOnly: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 14),
                hintText: country,
                suffixIcon: IconButton(
                  onPressed: () {
                    getCountry();
                  },
                  icon: Icon(
                    CupertinoIcons.forward,
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ), //Country selection TextField
            SizedBox(
              height: 15,
            ),
            TextField(
              focusNode: _emailFocus,
              controller: _emailController,
              onChanged: (email) {
                emailValidator(email);
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 14),
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Please enter your account ID',
                suffixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _emailFocused
                        ? _emailController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _emailController.clear();
                                  setState(() {
                                    isEmailValid = false;
                                  });
                                },
                                iconSize: 20,
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                ),
                              )
                            : Container()
                        : Container(),
                  ],
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              focusNode: _passwordFocus,
              controller: _passwordController,
              onChanged: (password) {
                passwordValidator(password);
              },
              textInputAction: TextInputAction.done,
              obscureText: !visible,
              obscuringCharacter: '•',
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 14),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Password',
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _passwordFocused
                          ? _passwordController.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    _passwordController.clear();
                                    setState(() {});
                                  },
                                  iconSize: 20,
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  ),
                                )
                              : Container()
                          : Container(),
                      IconButton(
                        onPressed: () {
                          if (visible)
                            setState(() {
                              visible = false;
                            });
                          else
                            setState(() {
                              visible = true;
                            });
                        },
                        iconSize: 20,
                        icon: Icon(
                          visible ? CupertinoIcons.eye : CustomIcon.close_eye,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  )),
            ),
            SizedBox(height: 15),
            Container(
              child: Text(
                userNotExist ? 'User not exist.'
                    : loginFailed ? 'Incorrect password! Try again...'
                    : error ? 'Something went wrong! Try again...' : '',
                style: TextStyle(
                    color: loginFailed || userNotExist || error ? Colors.red : Colors.white,
                    fontSize: 12),
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isEmailValid
                    ? _passwordController.text.isNotEmpty
                        ? login
                        : () {}
                    : () {},
                style: ElevatedButton.styleFrom(
                    // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    primary: isEmailValid
                        ? _passwordController.text.isNotEmpty
                            ? Colors.blue
                            : Colors.blue[100]
                        : Colors.blue[100]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loading ? SizedBox(
                      height: 20,
                      width: 20,
                      child: LoadingIndicator(
                        indicatorType: Indicator.lineSpinFadeLoader,
                        color: Colors.white,
                      ),
                    ) : Container(),
                    loading ? SizedBox(width: 10) : Container(),
                    Text(
                      'Log In',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ForgotPasswordScreen.id);
                    },
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void emailValidator(email) {
    if (email != null) {
      if (EmailValidator.validate(email)) {
        setState(() {
          isEmailValid = true;
        });
      } else {
        setState(() {
          isEmailValid = false;
        });
      }
    } else {
      setState(() {});
    }
  }

  void passwordValidator(password) {
    setState(() {});
  }

  void _onEmailFocusChange() {
    if (_emailFocus.hasFocus) {
      setState(() {
        _emailFocused = true;
      });
    } else {
      setState(() {
        _emailFocused = false;
      });
    }
  }

  void _onPasswordFocusChange() {
    if (_passwordFocus.hasFocus) {
      setState(() {
        _passwordFocused = true;
      });
    } else {
      setState(() {
        _passwordFocused = false;
      });
    }
  }

  void getCountry() async {
    final countryName =
        await Navigator.pushNamed(context, SelectCountryScreen.id);
    if (countryName != null) {
      setState(() {
        country = countryName.toString();
      });
    }
  }
}
