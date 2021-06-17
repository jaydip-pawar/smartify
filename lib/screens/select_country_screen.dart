import 'package:country_provider/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:smartify/constants.dart';

class SelectCountryScreen extends StatefulWidget {
  static const String id = 'select-country-screen';
  const SelectCountryScreen({Key? key}) : super(key: key);

  @override
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leadingWidth: width(context) * 0.2,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
        ),
        title: Text(
          'Select Region',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: CountryProvider.getAllCountries(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(color: Colors.black87,));
          } else {
            return Container(
              child: ListView.separated(
                itemCount: snapshot.data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.pop(context, snapshot.data[index].name);
                    },
                    title: Text(
                      snapshot.data[index].name,
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
            );
          }
        },
      ),
    );
  }
}
