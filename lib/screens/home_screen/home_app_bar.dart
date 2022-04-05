import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartify/screens/get_wifi_password_screen.dart';

AppBar buildAppBar(BuildContext context, List<Map<dynamic, dynamic>> tabs) {
  return AppBar(
    leadingWidth: 85,
    backgroundColor: Colors.grey[200],
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Icon(Icons.ac_unit),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              "25°C",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, GetWiFiPasswordScreen.id);
        },
        icon: Icon(Icons.add),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.notifications),
      ),
    ],
    bottom: tabs.length > 0 ? TabBar(
      isScrollable: true,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 3,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black26,
      tabs: tabs.map((tab) => Container(
        height: 30,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            tab['tag'],
            style: GoogleFonts.bebasNeue(
              fontSize: 21,
              letterSpacing: 1,
            ),
          ),
        ),
      )).toList(),
    ) : TabBar(tabs: [],),
  );
}