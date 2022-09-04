import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartify/widgets/scrollBehavior.dart';

class HomeView extends StatefulWidget {
  final DocumentSnapshot firstSnapshot;
  final int index;
  const HomeView({Key? key, required this.firstSnapshot, required this.index})
      : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final database = FirebaseDatabase.instance.ref();
  late DatabaseReference mydb;
  Map buttons = {};

  int nButtons = 0; //Number of buttons

  User? user = FirebaseAuth.instance.currentUser;

  updateValue(bool value, String boardName, int button) async {
    mydb = database.child('${user!.uid}/$boardName/');
    try {
      await mydb.child("button" + button.toString()).set(value);
      setState(() {});
    } catch (e) {
      print("Got an error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('boards')
            .doc(user!.uid)
            .collection(
                widget.firstSnapshot.get('boardNames')[widget.index]['name'])
            .doc("boardData")
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot1) {
          return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('boardNames')
                .doc(widget.firstSnapshot.get('boardNames')[widget.index]
                    ['name'])
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot2) {
              if (!snapshot1.hasData || !snapshot2.hasData) return Container();

              return Container(
                padding: EdgeInsets.only(top: 30.0, left: 20, right: 20),
                child: ScrollConfiguration(
                  behavior: SBehavior(),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 290,
                        crossAxisSpacing: 15,
                        childAspectRatio: 0.9),
                    itemCount: snapshot1.data!['buttons'],
                    itemBuilder: (BuildContext context, int index2) {
                      int ind = index2 + 1;
                      String path = user!.uid +
                          "/" +
                          widget.firstSnapshot.get('boardNames')[widget.index]
                              ['name'] +
                          "/button" +
                          ind.toString();
                      return StreamBuilder(
                        stream: database.child(path).onValue,
                        builder: (BuildContext context, AsyncSnapshot event) {
                          if(event.hasData) {
                            buttons.update(
                                "button${index2 + 1}",
                                    (existingValue) => () {
                                  return event.data!.snapshot.value;
                                },
                                ifAbsent: () => event.data!.snapshot.value);
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15, left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.tab_outlined,
                                        size: 30, color: Colors.blue),
                                    SizedBox(height: 15),
                                    Text(
                                      snapshot2.data!["button${index2 + 1}"]['name'],
                                      style: GoogleFonts.openSansCondensed(
                                        textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      snapshot2.data!["button${index2 + 1}"]['desc'],
                                      style: GoogleFonts.openSansCondensed(
                                        textStyle: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          FlutterSwitch(
                                            width: 55,
                                            height: 27,
                                            toggleSize: 25.0,
                                            value: event.hasData ? event.data!.snapshot.value : false,
                                            borderRadius: 30.0,
                                            padding: 2.0,
                                            inactiveToggleColor: Colors.blue,
                                            activeToggleColor: Colors.white,
                                            switchBorder: Border.all(
                                              color: Colors.blue,
                                              width: 1.5,
                                            ),
                                            activeColor: Colors.lightBlue,
                                            inactiveColor: Colors.white,
                                            onToggle: (val) {
                                              updateValue(
                                                  val,
                                                  widget.firstSnapshot
                                                          .get('boardNames')[
                                                      widget.index]['name'],
                                                  index2 + 1);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
