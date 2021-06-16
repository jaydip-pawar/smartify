import 'package:flutter/material.dart';
import 'package:smartify/screens/home_screen.dart';
import 'package:smartify/screens/login_screen.dart';
import 'package:smartify/screens/navigation_screen.dart';
import 'package:smartify/screens/sign_up_screen.dart';
import 'package:smartify/screens/splash_screen.dart';
import 'package:smartify/theme.dart';

void main() {
  runApp(MyApp()
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(
    //       create: (_) => AuthenticationProvider(),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (_) => LocationProvider(),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (_) => StoreProvider(),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (_) => CartProvider(),
    //     ),
    //   ],
    //   child: MyApp(),
    // ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // void initializeFlutterFire() async {
  //   await Firebase.initializeApp();
  // }
  //
  // @override
  // void initState() {
  //   initializeFlutterFire();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smartify',
      theme: theme(),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id : (context) => SplashScreen(),
        NavigationScreen.id : (context) => NavigationScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        SignUpScreen.id : (context) => SignUpScreen(),
        HomeScreen.id : (context) => HomeScreen(),
      },
    );
  }
}
