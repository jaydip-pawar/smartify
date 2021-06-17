import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartify/screens/select_country_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup-screen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var _emailController = TextEditingController();
  var _countryController = TextEditingController();
  String country = 'India';

  bool _emailFocused = false;
  bool isEmailValid = false;
  FocusNode _emailFocus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(_onEmailFocusChange);
  }

  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              height: 15,
            ),
            Text(
              'Register',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              onTap: () {
                getCountry();
              },
              controller: _countryController,
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
                hintText: 'Email',
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
              height: 35,
            ),
            Container(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isEmailValid ? getCode : () {},
                style: ElevatedButton.styleFrom(
                    // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    primary: isEmailValid ? Colors.blue : Colors.blue[100]),
                child: Text(
                  'Get Verification Code',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
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

  void getCountry() async {
    final countryName =
        await Navigator.pushNamed(context, SelectCountryScreen.id);
    setState(() {
      country = countryName.toString();
    });
  }

  void getCode() {}
}
