import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testfirebase/services/auth.dart';
import 'package:testfirebase/services/auth.dart';
import 'package:testfirebase/services/database.dart';
import 'package:provider/provider.dart';
import 'package:testfirebase/models/user.dart';
import 'package:testfirebase/screens/keskonfai/keskonfaiSolo.dart';
import 'package:testfirebase/screens/Profile/Profile.dart';
import 'package:testfirebase/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testfirebase/services/auth.dart';
import 'package:testfirebase/screens/keskonfai/keskonfaiSoloFilm.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String currentUserUid;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final AuthService _auth = AuthService();

  bool loading = false;

  Future<String> getCurrentUserUid() async {
    final FirebaseUser user = await auth.currentUser();
    print('getCurrentUserId() : $currentUserUid');
    return currentUserUid = user.uid;
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUserUid();

    return loading ? Loading() : StreamProvider<List<User>>.value(
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: Colors.deepOrange[300],
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.deepOrange[600],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.exit_to_app),
              label: Text('Déconnexion'),
              onPressed: () async {
                await _auth.signOut();
              }),
            FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Profil'),
                onPressed: () {
                  setState( () => loading = true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                  setState( () => loading = false);
                }
                ),
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Column(
            children: <Widget>[
              RaisedButton(//Bouton Solo
                color: Colors.pinkAccent,
                child: Text('Solo'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => KeskonfaiSolo()),
                  );
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(//Bouton Groupe
                color: Colors.blueGrey,
                child: Text('Groupe'),
                onPressed: () {//TODO Fonctionnement groupe
                  //Navigator.push(
                  //  context,
                  //  MaterialPageRoute(builder: (context) => KeskonfaiGroupe()),
                  //);

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
