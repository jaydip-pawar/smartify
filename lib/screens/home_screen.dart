import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:smartify/providers/authenticationProvider.dart';
import 'package:smartify/screens/adding_device_screen.dart';
import 'package:smartify/screens/board_connect.dart';
import 'package:smartify/screens/navigation_screen.dart';
import 'package:multiline/multiline.dart';
import 'package:smartify/services/user_services.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String email = '', country = '';
  String boardSsid = '', boardPassword = '';

  @override
  Widget build(BuildContext context) {

    final _authenticationProvider = Provider.of<AuthenticationProvider>(context);
    UserServices _userServices = UserServices();
    User? user = FirebaseAuth.instance.currentUser;

    showData() {
      _userServices.getUserById(user!.uid).then((value) {
        setState(() {
          email = value.data()!["email"];
          country = value.data()!["country"];
        });
        Navigator.pushNamed(context, WebSocketLed.id);
        // FlutterWifiConnect.connectToSecureNetwork(boardSsid, boardPassword).then((value) {
        //   if(value) {
        //     print('true: ${FlutterWifiConnect.ssid}');
        //   } else {
        //     print('false: ${FlutterWifiConnect.ssid}');
        //   }
        // });
      });
    }

    Future<void> scanQRCode() async {
      try {
        final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666',
          'Cancel',
          true,
          ScanMode.QR,
        );

        if (!mounted) return;

        var data = qrCode.multilineSplit();

        setState(() {
          boardSsid = data.elementAt(0);
          boardPassword = data.elementAt(1);
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AddingDeviceScreen(ssid: boardSsid, password: boardPassword,)));

      } on PlatformException {
        print('Failed to get platform version.');
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              scanQRCode();
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
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
              // scanQRCode();
            },
            child: Text('Show user Data'),
          ),
          Text('Country: $country'),
          Text('email: $email'),
          Text('ssid: $boardSsid'),
          Text('password: $boardPassword'),
          Text('uid: ${user!.uid}'),
        ],
      ),
    );
  }
}
