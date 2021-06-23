import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {

  final _fireStore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserById(String id) async {
    return await _fireStore.collection('user').doc(id).get();
  }

}