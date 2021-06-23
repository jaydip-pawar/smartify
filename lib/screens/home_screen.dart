import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartify/providers/authenticationProvider.dart';
import 'package:smartify/screens/navigation_screen.dart';
import 'package:smartify/services/user_services.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String email = '', country = '';

  @override
  Widget build(BuildContext context) {

    final _authenticationProvider = Provider.of<AuthenticationProvider>(context);
    UserServices _userServices = UserServices();
    User? user = FirebaseAuth.instance.currentUser;
    
    showData() {
      print(user!.uid);
      _userServices.getUserById(user!.uid).then((value) {
        setState(() {
          email = value.data()!["email"];
          country = value.data()!["country"];
        });
      });
    }

    return Scaffold(
      body: Column(
        children: [
          MaterialButton(
            onPressed: (){
              _authenticationProvider.signOut();
              Navigator.pushReplacementNamed(context, NavigationScreen.id);
            },
            child: Text('LogOut'),
          ),
          MaterialButton(
            onPressed: (){
              showData();
            },
            child: Text('Show user Data'),
          ),
          Text('Country: $country'),
          Text('email: $email'),
          Text('uid: ${user!.uid}'),
        ],
      ),
    );
  }
}
