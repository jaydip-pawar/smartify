import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartify/providers/authenticationProvider.dart';
import 'package:smartify/screens/navigation_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _authenticationProvider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: (){
            _authenticationProvider.signOut();
            Navigator.pushReplacementNamed(context, NavigationScreen.id);
          },
          child: Text('LogOut'),
        ),
      ),
    );
  }
}
