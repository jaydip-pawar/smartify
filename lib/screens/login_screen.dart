import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  bool _passwordFocused = false;
  bool _emailFocused = false;
  bool visible = false;
  FocusNode _passwordFocus = new FocusNode();
  FocusNode _emailFocus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(_onEmailFocusChange);
    _passwordFocus.addListener(_onPasswordFocusChange);
  }

  void _onEmailFocusChange(){
    if(_emailFocus.hasFocus){
      setState(() {
        _emailFocused = true;
      });
    } else {
      setState(() {
        _emailFocused = false;
      });
    }
  }

  void _onPasswordFocusChange(){
    if(_passwordFocus.hasFocus){
      setState(() {
        _passwordFocused = true;
      });
    } else {
      setState(() {
        _passwordFocused = false;
      });
    }
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
            SizedBox(height: 15,),
            Text('Log In', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),),
            SizedBox(height: 15,),
            TextField(
              focusNode: _emailFocus,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 14),
                  hintStyle: TextStyle(
                      color: Colors.grey
                  ),
                  hintText: 'Please enter your account ID',
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _emailFocused ? IconButton(
                        onPressed: (){},
                        iconSize: 20,
                        icon: Icon(Icons.close, color: Colors.grey,),
                      ) : Container(),
                    ],
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:  BorderSide(color: Colors.grey),
                  )
              ),
            ),
            TextField(
              focusNode: _passwordFocus,
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              obscuringCharacter: '•',
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 14),
                  hintStyle: TextStyle(
                      color: Colors.grey
                  ),
                  hintText: 'Password',
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _passwordFocused ? IconButton(
                        onPressed: (){},
                        iconSize: 20,
                        icon: Icon(Icons.close, color: Colors.grey,),
                      ) : Container(),
                      IconButton(
                        onPressed: () {},
                        iconSize: 20,
                        icon: Icon(CupertinoIcons.eye, color: Colors.grey,),
                      )
                    ],
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:  BorderSide(color: Colors.grey),
                  )
              ),
            ),
          ],
        ),
      )
    );
  }
}
