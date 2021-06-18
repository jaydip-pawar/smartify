import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartify/constants.dart';
import 'package:smartify/screens/country_search_screen.dart';

class SelectCountryScreen extends StatefulWidget {
  static const String id = 'select-country-screen';
  const SelectCountryScreen({Key? key}) : super(key: key);

  @override
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(105),
          child: Column(
            children: [
              Container(
                width: width(context),
                height: 50,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Select Region',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 17),
                        ),
                      ],
                    ),
                    Positioned(
                      height: 50,
                      width: 80,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: height(context) * 0.085,
                width: width(context),
                padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: TextField(
                  onTap: () {
                    Navigator.pushNamed(context, CountrySearchScreen.id);
                  },
                  textInputAction: TextInputAction.search,
                  readOnly: true,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    filled: true,
                    prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey,),
                    contentPadding: EdgeInsets.only(top: 14),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    hintText: 'Search',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                      borderSide: BorderSide.none,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ListView.separated(
          itemCount: countryName.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                Navigator.pop(context, countryName[index]);
              },
              title: Text(
                countryName[index],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 0,
            );
          },
        ),
      ),
    );
  }
}
