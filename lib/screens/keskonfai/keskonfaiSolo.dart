import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testfirebase/screens/Profile/Profile.dart';
import 'package:testfirebase/screens/keskonfai/keskonfaiSoloFilm.dart';
import 'package:testfirebase/services/auth.dart';
import 'package:testfirebase/services/auth.dart';
import 'package:testfirebase/services/database.dart';
import 'package:provider/provider.dart';
import 'package:testfirebase/models/user.dart';
import 'package:testfirebase/screens/keskonfai/keskonfaiSolo.dart';

class KeskonfaiSolo extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<User>>.value(
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: Colors.deepOrange[300],
        appBar: AppBar(
          title: Text('Activités'),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                }
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
                color: Colors.blueGrey,
                child: Text('Séries'),
                onPressed: () {

                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(//Bouton Sport
                color: Colors.blueGrey,
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
                color: Colors.blueGrey,
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
                color: Colors.blueGrey,
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
