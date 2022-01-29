import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartify/screens/home_screen/home_app_bar.dart';
import 'package:smartify/screens/home_screen/home_view.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String email = '', country = '';
  String boardSsid = '', boardPassword = '';
  List<Map<String, String>> _tabs = [];
  List<int> _views = [];

  User? user = FirebaseAuth.instance.currentUser;

  late Stream<DocumentSnapshot> documentStream;
  late DocumentSnapshot firstSnapshot;

  @override
  void initState() {
    documentStream = FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .snapshots();
    getTabCount();
    super.initState();
  }

  getTabCount() {
    documentStream.listen((snapshot) {
      setState(() {
        firstSnapshot = snapshot;
        int len = snapshot.get('nBoard');
        if (len > 0) {
          List<dynamic> tags = snapshot.get('boardNames');
          _tabs.clear();
          _views.clear();
          tags.forEach((element) {
            _tabs.add({'name': element['name'], 'tag': element['tag']});
            _views.add(_tabs.length);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: buildAppBar(context, _tabs),
        body: _tabs.length != 0
            ? TabBarView(
                children: _views
                    .map((index) => HomeView(
                        firstSnapshot: firstSnapshot, index: index - 1))
                    .toList(),
              )
            : Center(
                child: Text("Add Board"),
              ),
        // body:
      ),
    );
  }
}
