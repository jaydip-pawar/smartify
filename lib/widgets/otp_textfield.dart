import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartify/constants.dart';

class OtpTextField extends StatefulWidget {
  @override
  _OtpTextFieldState createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {

  FocusNode focusDigit1 = FocusNode();
  FocusNode focusDigit2 = FocusNode();
  FocusNode focusDigit3 = FocusNode();
  FocusNode focusDigit4 = FocusNode();
  FocusNode focusDigit5 = FocusNode();
  FocusNode focusDigit6 = FocusNode();

  TextEditingController digit1 = TextEditingController();
  TextEditingController digit2 = TextEditingController();
  TextEditingController digit3 = TextEditingController();
  TextEditingController digit4 = TextEditingController();
  TextEditingController digit5 = TextEditingController();
  TextEditingController digit6 = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    focusDigit1.dispose();
    focusDigit2.dispose();
    focusDigit3.dispose();
    focusDigit4.dispose();
    focusDigit5.dispose();
    focusDigit6.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CodeInput(
          focusDigit1: focusDigit1,
          focusDigit2: focusDigit2,
          focusDigit3: focusDigit3,
          focusDigit4: focusDigit4,
          focusDigit5: focusDigit5,
          focusDigit6: focusDigit6,
          digit1: digit1,
          digit2: digit2,
          digit3: digit3,
          digit4: digit4,
          digit5: digit5,
          digit6: digit6,
          controller: digit1,
          focusNode0: focusDigit5,
          focusNode1: focusDigit6,
          focusNode2: null,
        ),
        SizedBox(
          width: width(context) * 0.063,
        ),
        CodeInput(
          focusDigit1: focusDigit1,
          focusDigit2: focusDigit2,
          focusDigit3: focusDigit3,
          focusDigit4: focusDigit4,
          focusDigit5: focusDigit5,
          focusDigit6: focusDigit6,
          digit1: digit1,
          digit2: digit2,
          digit3: digit3,
          digit4: digit4,
          digit5: digit5,
          digit6: digit6,
          controller: digit2,
          focusNode0: focusDigit4,
          focusNode1: focusDigit5,
          focusNode2: focusDigit6,
        ),
        SizedBox(
          width: width(context) * 0.063,
        ),
        CodeInput(
          focusDigit1: focusDigit1,
          focusDigit2: focusDigit2,
          focusDigit3: focusDigit3,
          focusDigit4: focusDigit4,
          focusDigit5: focusDigit5,
          focusDigit6: focusDigit6,
          digit1: digit1,
          digit2: digit2,
          digit3: digit3,
          digit4: digit4,
          digit5: digit5,
          digit6: digit6,
          controller: digit3,
          focusNode0: focusDigit3,
          focusNode1: focusDigit4,
          focusNode2: focusDigit5,
        ),
        SizedBox(
          width: width(context) * 0.063,
        ),
        CodeInput(
          focusDigit1: focusDigit1,
          focusDigit2: focusDigit2,
          focusDigit3: focusDigit3,
          focusDigit4: focusDigit4,
          focusDigit5: focusDigit5,
          focusDigit6: focusDigit6,
          digit1: digit1,
          digit2: digit2,
          digit3: digit3,
          digit4: digit4,
          digit5: digit5,
          digit6: digit6,
          controller: digit4,
          focusNode0: focusDigit2,
          focusNode1: focusDigit3,
          focusNode2: focusDigit4,
        ),
        SizedBox(
          width: width(context) * 0.063,
        ),
        CodeInput(
          focusDigit1: focusDigit1,
          focusDigit2: focusDigit2,
          focusDigit3: focusDigit3,
          focusDigit4: focusDigit4,
          focusDigit5: focusDigit5,
          focusDigit6: focusDigit6,
          digit1: digit1,
          digit2: digit2,
          digit3: digit3,
          digit4: digit4,
          digit5: digit5,
          digit6: digit6,
          controller: digit5,
          focusNode0: focusDigit1,
          focusNode1: focusDigit2,
          focusNode2: focusDigit3,
        ),
        SizedBox(
          width: width(context) * 0.063,
        ),
        CodeInput(
          focusDigit1: focusDigit1,
          focusDigit2: focusDigit2,
          focusDigit3: focusDigit3,
          focusDigit4: focusDigit4,
          focusDigit5: focusDigit5,
          focusDigit6: focusDigit6,
          digit1: digit1,
          digit2: digit2,
          digit3: digit3,
          digit4: digit4,
          digit5: digit5,
          digit6: digit6,
          controller: digit6,
          focusNode0: null,
          focusNode1: focusDigit1,
          focusNode2: focusDigit2,
        ),
      ],
    );
  }
}

class CodeInput extends StatefulWidget {

  final focusDigit1;
  final focusDigit2;
  final focusDigit3;
  final focusDigit4;
  final focusDigit5;
  final focusDigit6;

  final digit1;
  final digit2;
  final digit3;
  final digit4;
  final digit5;
  final digit6;

  final focusNode0;
  final focusNode1;
  final focusNode2;
  final controller;

  const CodeInput({Key? key, this.focusNode0, this.focusNode1, this.focusNode2, this.controller, this.focusDigit1, this.focusDigit2, this.focusDigit3, this.focusDigit4, this.focusDigit5, this.focusDigit6, this.digit1, this.digit2, this.digit3, this.digit4, this.digit5, this.digit6}) : super(key: key);

  @override
  _CodeInputState createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width(context) * 0.070,
          child: TextField(
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600
            ),
            keyboardType: TextInputType.number,
            showCursor: false,
            controller: widget.controller,
            focusNode: widget.focusNode1,
            textAlign: TextAlign.center,
            maxLength: 1,
            onTap: checkValue,
            onChanged: (str) {
              if (str.length == 1) {
                FocusScope.of(context).requestFocus(widget.focusNode0);
              } else if (str.length == 0) {
                FocusScope.of(context).requestFocus(widget.focusNode2);
              }
            },
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.grey),
              counterText: "",
            ),
          ),
        ),
      ],
    );
  }

  void checkValue() {

    if(widget.digit1.text == '') {
      FocusScope.of(context).requestFocus(widget.focusDigit6);
    } else if(widget.digit2.text == '') {
      FocusScope.of(context).requestFocus(widget.focusDigit5);
    } else if(widget.digit3.text == '') {
      FocusScope.of(context).requestFocus(widget.focusDigit4);
    } else if(widget.digit4.text == '') {
      FocusScope.of(context).requestFocus(widget.focusDigit3);
    } else if(widget.digit5.text == '') {
      FocusScope.of(context).requestFocus(widget.focusDigit2);
    } else if(widget.digit6.text == '') {
      FocusScope.of(context).requestFocus(widget.focusDigit1);
    }
  }
}