import 'package:code_input/code_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartify/constants.dart';
import 'package:smartify/providers/authenticationProvider.dart';
import 'package:smartify/screens/home_screen.dart';

class OtpTextField extends StatefulWidget {
  final inputKey;

  const OtpTextField({Key? key, required this.inputKey}) : super(key: key);
  @override
  _OtpTextFieldState createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {

  @override
  Widget build(BuildContext context) {
    return CodeInput(
      key: widget.inputKey,
      spacing: width(context) * 0.063,
      length: 6,
      keyboardType: TextInputType.number,
      builder: (bool hasFocus, String char) {
        return Container(
          width: width(context) * 0.070,
          child: Column(
            children: [
              Text(char, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
              Divider(thickness: 2, height: 1, color: hasFocus ? Colors.blue : Colors.black,)
            ],
          ),
        );
      },
      onFilled: (otp) {
        final _authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
        _authenticationProvider.verifyOTP(otp).then((value) {
          if(value)
            Navigator.pushReplacementNamed(context, HomeScreen.id);
          else
            print('Wrong otp');
        });
      },
    );
  }
}
