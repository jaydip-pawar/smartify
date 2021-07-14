import 'package:flutter/material.dart';
import 'package:smartify/constants.dart';

class DeviceNotFoundScreen extends StatelessWidget {
  static const String id = 'device-not-found-screen';
  const DeviceNotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height(context) * 0.07,
        elevation: 0.5,
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
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  child: Text(
                    'Report Issue',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 60, left: 25, right: 25),
            child: Column(
              children: [
                Text(
                  'Connection timed out',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Text(
                  'Check demerit points and retry',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 25, left: 50, right: 50, bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1. Check if the device has been reset and the indicator is blinking quickly.',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '2. Check if it is 2.4 GHz Wi-Fi.',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '3. Verify the Wi-Fi password.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 45,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 65, right: 65),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(60))),
                      child: Center(
                        child: Text(
                          'Retry',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 45,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 65, right: 65),
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[400],
                          border: Border.all(
                            color: Color(0xFF42A5F5),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(60))),
                      child: Center(
                        child: Text(
                          'Switch Pairing Mode',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "More device-pairing FAQs",
                    style: TextStyle(
                      fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 70,
          ),
        ],
      ),
    );
  }
}
