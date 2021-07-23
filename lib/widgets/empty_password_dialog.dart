import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartify/constants.dart';
import 'package:smartify/providers/deviceProvider.dart';
import 'package:smartify/screens/adding_device_screen.dart';

class EmptyPasswordDialog extends StatelessWidget {

  final wifiSSID, wifiPassword;

  const EmptyPasswordDialog({Key? key, this.wifiSSID, this.wifiPassword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
          height: height(context) * 0.22,
          width: width(context) * 0.85,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  // color: Colors.blue,
                  height: height(context) * 0.07,
                  child: Center(
                    child: Text(
                      'Password field is blank',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17
                      ),
                    ),
                  ),
                ),
              ),
              Divider(height: 0, thickness: 2,),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text('Cancel', style: TextStyle(color: Colors.grey.shade600),),
                      ),
                    ),
                    VerticalDivider(width: 1, thickness: 2,),
                    Expanded(
                      child: MaterialButton(
                        onPressed: (){
                          final _deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
                          _deviceProvider.setSsidPassword(wifiSSID, wifiPassword);
                          Navigator.pop(context);
                          Navigator.pushNamed(context, AddingDeviceScreen.id);
                        },
                        child: Text('Continue', style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
