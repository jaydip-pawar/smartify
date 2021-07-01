import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartify/constants.dart';
import 'package:smartify/widgets/add_device_timer.dart';
import 'package:smartify/widgets/filled_track_progressbar.dart';
import 'package:flutter_wifi_connect/flutter_wifi_connect.dart';

class AddingDeviceScreen extends StatefulWidget {
  static const String id = 'adding-device-screen';
  const AddingDeviceScreen({Key? key}) : super(key: key);

  @override
  _AddingDeviceScreenState createState() => _AddingDeviceScreenState();
}

class _AddingDeviceScreenState extends State<AddingDeviceScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white30,
          leadingWidth: width(context) * 0.18,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
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
                  Column(
                    children: [
                      Container(
                        height: height(context) * 0.28,
                        width: width(context) * 0.5,
                        child: Stack(
                          children: [
                            Align(child: FilledTrackIndeterminateProgressbar()),
                            Align(
                              child: CircleAvatar(
                                radius: width(context) * 0.1,
                                backgroundColor:
                                    Colors.blueAccent[200]!.withOpacity(0.5),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: AddDeviceTimer(),
                            )
                          ],
                        ),
                      ),
                      // AddDeviceTimer(),
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
}
