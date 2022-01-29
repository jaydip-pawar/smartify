import 'dart:async';
import 'dart:typed_data';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'package:smartify/constants.dart';
import 'package:smartify/providers/deviceProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartify/screens/device_not_found_screen.dart';
import 'package:smartify/screens/home_screen/home_screen.dart';
import 'package:smartify/widgets/filled_track_progressbar.dart';

bool scanning = true;
bool registering = false;
bool initializing = false;

class AddingDeviceScreen extends StatefulWidget {
  static const String id = 'adding-device-screen';
  const AddingDeviceScreen({Key? key}) : super(key: key);

  @override
  _AddingDeviceScreenState createState() => _AddingDeviceScreenState();
}

class _AddingDeviceScreenState extends State<AddingDeviceScreen> {
  late StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  List<BluetoothDiscoveryResult> results = [];

  var _timer;
  int seconds = 59;
  int minutes = 1;
  late String message;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    startTimer();
    connectWithDevice();
    super.initState();
  }

  void connectWithDevice() {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      results.add(r);
      for (BluetoothDiscoveryResult device in results) {
        if (device.device.name == "SMARTIFY") {
          print("Device found");
          _streamSubscription.cancel();
          getDataFromBluetooth(device.device);
          break;
        }
      }
    });
    _streamSubscription.onDone(() {
      connectWithDevice();
    });
  }

  Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }

  void getDataFromBluetooth(BluetoothDevice device) async {
    final _deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
    try {
      await BluetoothConnection.toAddress(device.address).then((_connection) {
        print("Successfully connected");
        setState(() {
          scanning = false;
          initializing = false;
          registering = true;
          seconds = 59;
          minutes = 1;
        });

        String cmd =
            "${_deviceProvider.wifiSSID}\n${_deviceProvider.wifiPassword}\n${user!.uid}";
        _connection.output.add(
            convertStringToUint8List(cmd)); // Sends user credentials to ESP32

        _connection.input!.listen((Uint8List data) {
          print("Now listening to the server");
          message = String.fromCharCodes(data);

          if (processBoardData(message)) {
            _connection.finish(); // Closing connection
            print('Disconnecting by local host');

            setState(() {
              scanning = false;
              initializing = true;
              registering = false;
              seconds = 59;
              minutes = 1;
            });
            checkBoardConnectivity();
          }
        }).onDone(() {
          print('Disconnected by remote request');
          // TODO: turn the bluetooth off later
        });
      });
    } catch (exception) {
      print('Cannot connect, exception occured');
    }
  }

  bool processBoardData(String message) {
    List splattedString = message.split(":");
    if (splattedString[1] != null) {
      final _deviceProvider =
          Provider.of<DeviceProvider>(context, listen: false);
      _deviceProvider.setDeviceName(splattedString[1]);
    }
    return true;
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      setState(
        () {
          if (seconds == 0 && minutes == 0) {
            if (scanning) {
              Navigator.pushReplacementNamed(context, DeviceNotFoundScreen.id);
            } else if (registering) {
              Navigator.pushReplacementNamed(context, DeviceNotFoundScreen.id);
            } else {
              Navigator.pushReplacementNamed(context, DeviceNotFoundScreen.id);
            }
            timer.cancel();
          } else if (seconds == 0) {
            minutes = minutes - 1;
            seconds = 59;
          } else {
            seconds = seconds - 1;
          }
        },
      );
    });
  }

  void checkBoardConnectivity() {
    final _deviceProvider = Provider.of<DeviceProvider>(context, listen: false);

    FirebaseFirestore.instance
        .collection('boards')
        .doc(user!.uid)
        .collection(_deviceProvider.deviceName)
        .doc("boardData")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Navigator.pushReplacementNamed(context, HomeScreen.id);
        print('Document exists on the database');
      } else {
        print('Document not exists...');
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _streamSubscription.cancel();
    scanning = true;
    registering = false;
    initializing = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white30,
          leadingWidth: width(context) * 0.18,
          leading: GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, HomeScreen.id),
            child: Center(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          width: width(context),
          height: height(context),
          color: Colors.white30,
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: Material(
            color: Colors.white,
            elevation: 3,
            shadowColor: Colors.white24,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(28.0),
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 37),
                      Text(
                        'Adding device...',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 18),
                      Container(
                        width: double.infinity,
                        height: height(context) * 0.05,
                        child: AnimatedTextKit(
                          animatedTexts: [
                            RotateAnimatedText(
                                'Ensure that the Bluetooth signal is good.'),
                            RotateAnimatedText(
                                'Ensure that the device is powered on.'),
                            RotateAnimatedText(
                                'Ensure that the device has an active internet connection.'),
                          ],
                          pause: Duration.zero,
                          repeatForever: true,
                        ),
                      ),
                    ],
                  ),
                  scanning
                      ? Column(
                          children: [
                            Container(
                              height: height(context) * 0.28,
                              width: width(context) * 0.5,
                              child: Stack(
                                children: [
                                  Align(
                                      child:
                                          FilledTrackIndeterminateProgressbar()),
                                  Align(
                                    child: CircleAvatar(
                                      radius: width(context) * 0.1,
                                      backgroundColor: Colors.blueAccent[200]!
                                          .withOpacity(0.5),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: timer(),
                                  )
                                ],
                              ),
                            ),
                            // AddDeviceTimer(),
                          ],
                        )
                      : registering
                          ? Column(
                              children: [
                                Container(
                                    height: height(context) * 0.28,
                                    width: width(context) * 0.5,
                                    child: Image.asset(
                                        "assets/images/connecting_with_server.gif")),
                                timer(),
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                    height: height(context) * 0.28,
                                    width: width(context) * 0.5,
                                    child: Image.asset(
                                        "assets/images/moving_gears.gif")),
                                timer(),
                              ],
                            ),
                  Container(
                    width: double.maxFinite,
                    height: height(context) * 0.17,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: height(context) * 0.17,
                          width: width(context) * 0.3,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 2, right: 2),
                                      child: Divider(
                                        color: Colors.white,
                                        thickness: 0.8,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.blueAccent[200],
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: scanning
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 3,
                                            )
                                          : Container(),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 2),
                                      child: Divider(
                                        color: Colors.grey,
                                        thickness: 0.8,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Container(
                                width: width(context) * 0.2,
                                child: Text(
                                  'Scan devices.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: height(context) * 0.17,
                          width: width(context) * 0.3,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 2),
                                      child: Divider(
                                        color: Colors.grey,
                                        thickness: 0.8,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.blueAccent[200],
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: registering
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 3,
                                            )
                                          : Container(),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 2),
                                      child: Divider(
                                        color: Colors.grey,
                                        thickness: 0.8,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Container(
                                width: width(context) * 0.2,
                                child: Text(
                                  'Register on Cloud.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: height(context) * 0.17,
                          width: width(context) * 0.3,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 2),
                                      child: Divider(
                                        color: Colors.grey,
                                        thickness: 0.8,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.blueAccent[200],
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: initializing
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 3,
                                            )
                                          : Container(),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 2),
                                      child: Divider(
                                        color: Colors.white,
                                        thickness: 0.8,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Container(
                                width: width(context) * 0.2,
                                child: Text(
                                  'Initialize the device.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget timer() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '0$minutes:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          seconds <= 9
              ? Text(
                  '0$seconds',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                )
              : Text(
                  '$seconds',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
        ],
      ),
    );
  }
}
