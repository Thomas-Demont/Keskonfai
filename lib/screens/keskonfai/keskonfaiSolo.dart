import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testfirebase/screens/home/settings_form.dart';
import 'package:testfirebase/screens/keskonfai/keskonfaiSoloFilm.dart';
import 'package:testfirebase/services/auth.dart';
import 'package:testfirebase/services/auth.dart';
import 'package:testfirebase/services/database.dart';
import 'package:provider/provider.dart';
import 'package:testfirebase/screens/home/user_list.dart';
import 'package:testfirebase/models/user.dart';
import 'package:testfirebase/screens/home/settings_form.dart';
import 'package:testfirebase/screens/keskonfai/keskonfaiSolo.dart';

class KeskonfaiSolo extends StatelessWidget {

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
              RaisedButton(//Bouton Films
                color: Colors.pinkAccent,
                child: Text('Films'),
                onPressed: () {//TODO ouvrir keskonfai films
                  Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => KeskonfaiSoloFilm()),
                  );
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(//Bouton Séries
                color: Colors.pinkAccent,
                child: Text('Séries'),
                onPressed: () {

                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(//Bouton Sport
                color: Colors.pinkAccent,
                child: Text('Sport'),
                onPressed: () {//TODO Fonctionnement groupe
                  //Navigator.push(
                  //  context,
                  //  MaterialPageRoute(builder: (context) => KeskonfaiGroupe()),
                  //);

                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(//Bouton Nourriture
                color: Colors.pinkAccent,
                child: Text('Nourriture'),
                onPressed: () {//TODO Fonctionnement groupe
                  //Navigator.push(
                  //  context,
                  //  MaterialPageRoute(builder: (context) => KeskonfaiGroupe()),
                  //);

                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(//Bouton Jeux Video
                color: Colors.pinkAccent,
                child: Text('Jeux Video'),
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
