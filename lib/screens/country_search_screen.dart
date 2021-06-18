import 'package:flutter/material.dart';
import 'package:smartify/constants.dart';

class CountrySearchScreen extends StatefulWidget {
  static const String id = 'country-search-screen';
  const CountrySearchScreen({Key? key}) : super(key: key);

  @override
  _CountrySearchScreenState createState() => _CountrySearchScreenState();
}

class _CountrySearchScreenState extends State<CountrySearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: Hero(
            tag: 'SearchBar',
            child: AppBar(
              elevation: 1,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Container(
                height: height(context) * 0.085,
                width: width(context),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    filled: true,
                    contentPadding: EdgeInsets.only(top: 14, left: 15),
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
            ),
          ),
        ),
      ),
    );
  }
}
