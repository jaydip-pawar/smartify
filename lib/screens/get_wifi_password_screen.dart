import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_utils/widgets.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:smartify/providers/deviceProvider.dart';
import 'package:smartify/screens/adding_device_screen.dart';
import 'package:smartify/widgets/custom_icon.dart';
import 'package:smartify/widgets/empty_password_dialog.dart';
import 'package:smartify/constants.dart';
import 'package:open_settings/open_settings.dart';

class GetWiFiPasswordScreen extends StatefulWidget {
  static const String id = 'get-wifi-password-screen';
  const GetWiFiPasswordScreen({Key? key}) : super(key: key);

  @override
  _GetWiFiPasswordScreenState createState() => _GetWiFiPasswordScreenState();
}

class _GetWiFiPasswordScreenState extends State<GetWiFiPasswordScreen>
    with WidgetsBindingObserver {
  String wifiName = "";
  bool visible = false;

  TextEditingController wifiSSID = TextEditingController();
  TextEditingController wifiPassword = TextEditingController();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) getSSID();
  }

  @override
  void initState() {
    getSSID();
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  getSSID() async {
    NetworkInfo().getWifiName().then((value) {
      if (value != null)
        setState(() {
          wifiSSID.text = value;
        });
      else
        setState(() {
          wifiSSID.clear();
          wifiName = "Turn on WiFi";
        });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: Center(
          child: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                child: Text(
                  'Close',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: width(context),
        height: height(context),
        color: Colors.white30,
        padding: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
        child: Material(
          color: Colors.white,
          elevation: 3,
          shadowColor: Colors.white24,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
          child: Container(
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 10),
                  child: Text(
                    'Select 2.4 GHz Wi-Fi Network and enter password.',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ), // Heading
                Container(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 5),
                  child: Text(
                    'If your Wi-Fi is 5GHz, please set it to be 2.4GHz. Common router setting method.',
                    textAlign: TextAlign.center,
                  ),
                ), // instruction text
                KeyboardAware(
                  builder: (context, keyboardConfig) {
                    return keyboardConfig.isKeyboardOpen
                        ? Container()
                        : Container(
                            padding: EdgeInsets.only(
                                left: 25, right: 25, bottom: 10, top: 20),
                            child:
                                Image.asset("assets/images/select_wifi.jpeg"),
                          ); // Image
                  },
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
                  child: Column(
                    children: [
                      TextField(
                        readOnly: true,
                        controller: wifiSSID,
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: wifiName,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 9),
                            child: Icon(
                              Icons.wifi,
                              color: Colors.grey,
                            ),
                          ),
                          suffixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 9),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      OpenSettings.openWIFISetting();
                                    },
                                    iconSize: 18,
                                    icon: Icon(
                                      CupertinoIcons
                                          .arrow_down_right_arrow_up_left,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                      Divider(thickness: 1, height: 25),
                      TextField(
                        controller: wifiPassword,
                        textInputAction: TextInputAction.done,
                        onChanged: (password) {
                          passwordValidator(password);
                        },
                        obscureText: !visible,
                        obscuringCharacter: '•',
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                wifiPassword.text.isNotEmpty
                                    ? IconButton(
                                        onPressed: () {
                                          if (visible)
                                            setState(() {
                                              visible = false;
                                            });
                                          else
                                            setState(() {
                                              visible = true;
                                            });
                                        },
                                        iconSize: 18,
                                        icon: Icon(
                                          visible
                                              ? CupertinoIcons.eye
                                              : CustomIcon.close_eye,
                                          color: Colors.grey,
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 9),
                            child: Icon(
                              Icons.lock_outline,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 40,
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: GestureDetector(
                          onTap: () {
                            validateFields();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                border: Border.all(
                                  color: Colors.blue,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60))),
                            child: Center(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                          ),
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
    );
  }

  void passwordValidator(password) {
    setState(() {});
  }

  void validateFields() {
    if (wifiSSID.text.isNotEmpty) {
      if (wifiPassword.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return EmptyPasswordDialog(wifiSSID: wifiSSID.text, wifiPassword: wifiPassword.text);
          },
        );
      } else {
        final _deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
        _deviceProvider.setSsidPassword(wifiSSID.text, wifiPassword.text);
        Navigator.pushNamed(context, AddingDeviceScreen.id);
      }
    }
  }
}
