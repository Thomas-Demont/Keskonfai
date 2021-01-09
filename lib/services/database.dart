import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testfirebase/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid});

  //Collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String name) async {
    return await userCollection.document(uid).setData({
      'name': name,
    });
  }

  //get user list from snapshot
  List<User> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return User(
        uid: doc.data['uid'] ?? '',
        name: doc.data['name'] ?? '',
      );
      }).toList();
  }

  //get user stream
  Stream<List<User>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

  //get user doc stream
  Stream<DocumentSnapshot> get UserData {
    return userCollection.document(uid).snapshots();
  }
}