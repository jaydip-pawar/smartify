import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:smartify/constants.dart';

class VerifyUserScreen extends StatefulWidget {
  static const String id = 'verify-user-screen';
  const VerifyUserScreen({Key? key}) : super(key: key);

  @override
  _VerifyUserScreenState createState() => _VerifyUserScreenState();
}

class _VerifyUserScreenState extends State<VerifyUserScreen> {
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
              'Enter Verification Code',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              child: OTPTextField(
                length: 6,
                fieldWidth: width(context) * 0.1,
                style: TextStyle(
                    fontSize: 17
                ),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  print(width(context) * 0.1);
                  print("Completed: " + pin);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
