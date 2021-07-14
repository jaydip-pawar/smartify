import 'package:flutter/material.dart';
import 'package:smartify/constants.dart';
import 'package:smartify/screens/home_screen.dart';
import 'package:smartify/screens/login_screen.dart';
import 'package:smartify/screens/sign_up_screen.dart';
import 'package:smartify/widgets/license_dialog.dart';

class NavigationScreen extends StatelessWidget {
  static const String id = 'navigation-screen';
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: height(context) * 0.3,
              width: width(context) * 0.3,
              child: Image.asset('assets/logo/logo.png'),
            ),
            Column(
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 45, right: 45),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => LicenseDialog(routeName: LoginScreen.id,),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        primary: Colors.white),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 45, right: 45),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => LicenseDialog(routeName: SignUpScreen.id,),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        primary: Colors.blue),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, HomeScreen.id);
                  },
                  child: Text(
                    'SKIP',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
