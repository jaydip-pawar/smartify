import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartify/screens/get_wifi_password_screen.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String email = '', country = '';
  String boardSsid = '', boardPassword = '';

  int nBoard = 0; //Number of boards
  int nButtons = 0; //Number of buttons

  final database = FirebaseDatabase.instance.reference();
  late DatabaseReference mydb;
  Map buttons = {};

  User? user = FirebaseAuth.instance.currentUser;

  late Stream<DocumentSnapshot> documentStream;

  updateValue(bool value, String boardName, int button) async {
    mydb = database.child('$boardName/');
    try {
      await mydb.child("button" + button.toString()).set(value);
      setState(() {});
    } catch (e) {
      print("Got an error");
    }
  }

  @override
  void initState() {
    documentStream = FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, GetWiFiPasswordScreen.id);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: documentStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error found");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.data!['nBoard'] == 0) {
            return Text("Add Device");
          } else if (snapshot.data!['nBoard'] > 0) {
            nBoard = snapshot.data!['nBoard'];
            // return Text(nBoard.toString());
          }

          return Container(
            child: ListView.builder(
              itemCount: nBoard,
              itemBuilder: (BuildContext context, int index) {
                return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('boards')
                      .doc(user!.uid)
                      .collection(snapshot.data!['boardNames'][index])
                      .doc("boardData")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot1) {
                    return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('boardNames')
                          .doc(snapshot.data!['boardNames'][index])
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot2) {
                        if (!snapshot1.hasData || !snapshot2.hasData)
                          return Container();

                        return Column(
                          children: [
                            Text("Board Name: " +
                                snapshot.data!['boardNames'][index]),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot1.data!['buttons'],
                              itemBuilder: (BuildContext context, int index2) {
                                print("index : $index2");
                                int ind = index2 + 1;
                                String path = snapshot.data!['boardNames']
                                        [index] +
                                    "/button" +
                                    ind.toString();
                                print(path);
                                return StreamBuilder<Event>(
                                  stream: database.child(path).onValue,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<Event> event) {
                                    buttons.update(
                                        "button${index2+1}",
                                        (existingValue) => () {
                                              return event.data!.snapshot.value;
                                            },
                                        ifAbsent: () =>
                                            event.data!.snapshot.value);

                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(snapshot2.data!["button${index2+1}"]['name']),
                                        Container(
                                          child: Switch(
                                            onChanged: (value) => updateValue(value, snapshot.data!['boardNames'][index], index2 + 1),
                                            value: event.data!.snapshot.value,
                                            activeColor: Colors.blue,
                                            activeTrackColor: Colors.yellow,
                                            inactiveThumbColor: Colors.redAccent,
                                            inactiveTrackColor: Colors.orange,
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
