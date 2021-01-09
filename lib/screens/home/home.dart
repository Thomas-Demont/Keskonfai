import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testfirebase/screens/home/settings_form.dart';
import 'package:testfirebase/services/auth.dart';
import 'package:testfirebase/services/auth.dart';
import 'package:testfirebase/services/database.dart';
import 'package:provider/provider.dart';
import 'package:testfirebase/screens/home/user_list.dart';
import 'package:testfirebase/models/user.dart';
import 'package:testfirebase/screens/home/settings_form.dart';
import 'package:testfirebase/screens/keskonfai/keskonfaiSolo.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<User>>.value(
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              }),
            FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
                onPressed: () => _showSettingsPanel(),
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
                color: Colors.pinkAccent,
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
