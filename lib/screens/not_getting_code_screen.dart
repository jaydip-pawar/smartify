import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartify/constants.dart';

class NotGetCode extends StatelessWidget {
  static const String id = 'not-get-code-screen';
  const NotGetCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back),
        ),
        title: Text("Didn't get a code?",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        height: height(context),
        width: width(context),
        color: Colors.white,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Text('If you did not receive verification code, please ensure that :',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 23,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 25),
              child: Text(
                "1. Ensure e-mail address is correct.\n"
                    "2. Ensure e-mail is not in Junk.\n"
                    "3. If you can not find the email, it might be blocked by your firewall."
                    " Please use an email with better compatibility.\n"
                    "4. Please contact our customer service and provide account name, time if "
                    "you still can not get the code.",
                style: TextStyle(
                  height: 1.5,
                  fontSize: 17,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
