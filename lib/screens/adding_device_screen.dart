import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:simply_wifi/simply_wifi.dart';
import 'package:smartify/constants.dart';
import 'package:smartify/providers/deviceProvider.dart';
import 'package:smartify/screens/device_not_found_screen.dart';
import 'package:smartify/screens/home_screen.dart';
import 'package:smartify/widgets/filled_track_progressbar.dart';
import 'package:web_socket_channel/io.dart';
import 'package:wifi_iot/wifi_iot.dart';

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

  // wifi connection
  late bool disposed;
  String boardSSID = "Smartify";
  String boardPassword = "12345678";

  // board connection
  late IOWebSocketChannel channel;
  late bool connected;

  var _timer;
  int seconds = 59;
  int minutes = 1;

  @override
  void initState() {
    disposed = false;
    startTimer();
    getSSID();
    super.initState();
  }

  getSSID() async {
    NetworkInfo().getWifiName().then((value) {
      if (value != null && value != 'Smartify') {
        setState(() {
          scanning = true;
          registering = false;
          initializing = false;
        });
        // connectWithWifi();
        List list = [];
        scanWifi().then((value) {
          value.forEach((element) {
            list.add(element.ssid);
          });
          if(list.contains("Smartify")) connectWithWifi();
          else getSSID();
        });
      } else {
        if(value != "" && registering) {
          channelConnect();
        }
      }
    });
  }

  Future<List<WifiNetwork>> scanWifi() {
    return SimplyWifi.getListOfWifis();
  }

  channelConnect(){ //function to connect
    print("Channel Connect called");
    try{
      channel = IOWebSocketChannel.connect("ws://192.168.0.1:81"); //channel IP : Port
      channel.stream.listen((message) {
        print(message);
        setState(() {
          if(message == "connected"){
            print("Web connected");
            setState(() {
              connected = true;
            });
            sendCmd();
          }else if(message == "success"){
            print("Web updated");
            setState(() {
              scanning = false;
              registering = false;
              initializing = false;
            });
          }
        });
      },
        onDone: () {
          print("Web socket is closed");
          setState(() {
            connected = false;
          });
        },
        onError: (error) {
          print("e:"+error.toString());
          channelConnect();
        },);
    }catch (_){
      print("error on connecting to websocket.");
      channelConnect();
    }
  }

  Future<void> sendCmd() async {
    final _deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
    String cmd = "${_deviceProvider.wifiSSID}\n${_deviceProvider.wifiPassword}";
    print("SSID and Password: $cmd");
    if(connected == true){
      if(cmd.isNotEmpty) channel.sink.add(cmd);
    }else{
      channelConnect();
      print("Websocket is not connected.");
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      setState(
        () {
          if (seconds == 0 && minutes == 0) {
            if(scanning) {
              Navigator.pushReplacementNamed(context, DeviceNotFoundScreen.id);
            } else if(registering) {
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

  void connectWithWifi() async {
    if (!disposed) {
      SimplyWifi.connectWifiByName(boardSSID, password: boardPassword)
          .then((value) {
        if (value) {
          NetworkInfo().getWifiName().then((value) {
            if(value == "Smartify") {
              print('connected');
              setState(() {
                scanning = false;
                seconds = 59;
                minutes = 1;
                registering = true;
              });
              Future.delayed(Duration(seconds: 5), (){
                channelConnect();
              });
            } else {
              getSSID();
            }
          });
        } else {
          print('not connected');
          connectWithWifi();
        }
      });
    }
  }

  @override
  void dispose() {
    disposed = true;
    _timer.cancel();
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
                                'Ensure that the WI-FI signal is good.'),
                            RotateAnimatedText(
                                'Ensure that the device is powered on.'),
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
                                      child: scanning ? CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ) : Container(),
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
                                      child: registering ? CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ) : Container(),
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
                                      child: initializing ? CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ) : Container(),
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
