import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testfirebase/services/auth.dart';
import 'package:testfirebase/screens/keskonfai/keskonfaiSoloFilm.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  final FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUserUid();
  }


  Future<String> getCurrentUserUid() async {
    final FirebaseUser user = await auth.currentUser();
    setState(() {
      currentUserUid = user.uid;
    });
    //print('getCurrentUserId() : $currentUserUid');
  }

  void attendre() async {
    await Future.delayed(const Duration(milliseconds: 300), (){});
  }

  void getDataFromCollection(String collection, String idUser) async {
    setState(() async {
      await Firestore.instance.collection(collection).document(idUser)
          .get().then((documentSnapshot) {
        prenom = documentSnapshot.data['prenom'].toString();
        name = documentSnapshot.data['nom'].toString();
        dropdownValueAge = documentSnapshot.data['age'].toString();
        dropdownValueGender = documentSnapshot.data['gender'].toString();
      });
    });
    print("cest un nom $name");
  }


  void getFilmActuel() async{
    await Firestore.instance.collection('Users').document(currentUserUid)
        .get().then((documentSnapshot) {
      filmActuel = documentSnapshot.data['id_fi'];
    });
  }
  void getMovieIdFromLikes(int filmActuel) async{
    String doc = currentUserUid + filmActuel.toString();
    await Firestore.instance.collection('regarder').document(doc)
        .get().then((documentSnapshot) {
      idFilmAimes.add(documentSnapshot.data['id_movie']);
    });
  }

  void getMovieNameFromLikes(List<int> idFilmAimes) async {
    int len = idFilmAimes.length;
    for (var i = 1; i <= len; i++) {
      if (idFilmAimes.contains(i)) {
        await Firestore.instance.collection('films').document(i.toString())
            .get().then((documentSnapshot) {
          filmAimes.add(documentSnapshot.data['titre_film']);
        });
      }
      else {
        await Firestore.instance.collection('films').document(i.toString())
            .get().then((documentSnapshot) {
          filmPasAimes.add(documentSnapshot.data['titre_film']);
        });
      }
    }
  }

  void setChanges(String prenom, String name, String dropdownValueAge, String dropdownValueGender) async{
    Firestore.instance.collection('Users').document(currentUserUid).updateData({'nom': name});
    Firestore.instance.collection('Users').document(currentUserUid).updateData({'prenom': prenom});
    Firestore.instance.collection('Users').document(currentUserUid).updateData({'age': dropdownValueAge});
    Firestore.instance.collection('Users').document(currentUserUid).updateData({'gender': dropdownValueGender});
  }

  @override
  String prenom = '';
  String name = '';
  String dropdownValueAge = "16-25";
  String dropdownValueGender = "Femme";
  String gender = '';
  String error = '';
  String currentUserUid;
  int filmActuel;
  List<int> idFilmAimes = new List();
  List<String> filmAimes = new List();
  List<String> filmPasAimes = new List();


  Widget build(BuildContext context) {
    
    //getCurrentUserUid();
    //attendre();
      getDataFromCollection('Users', currentUserUid);
    print('getCurrentUserId() : $currentUserUid');
    print("cest un nom $name");
    return Scaffold(
      backgroundColor: Colors.deepOrange[300],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[600],
        elevation: 0.0,
        title: Text('Profil'),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(//name
                  decoration: InputDecoration(
                      hintText: 'nom : $name',
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0)
                      )
                  ),
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(//name
                  decoration: InputDecoration(
                      hintText: 'prenom : $prenom',
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0)
                      )
                  ),
                  onChanged: (val) {
                    setState(() => prenom = val);
                  },
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField<String>(//Age
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Age',
                  ),
                  value: dropdownValueAge,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValueAge = newValue;
                    });
                  },
                  items: <String>['-15', '16-25', '25-40', '40-55', '55+']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),

                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField<String>(//Gender
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Gender',
                  ),
                  value: dropdownValueGender,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValueGender = newValue;
                    });
                  },
                  items: <String>['Femme', 'Homme', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Save changes',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        setChanges(prenom, name, dropdownValueAge, dropdownValueGender);
                    }
                    }

                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.blueGrey,
                    child: Text(
                      'Films aimés',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await getFilmActuel();
                      await getMovieIdFromLikes(filmActuel);
                      await getMovieNameFromLikes(idFilmAimes);
                      showModalBottomSheet(context: context, builder: (context) {
                        return Column(
                          children: <Widget>[
                            Text(filmAimes[0]),
                            Text(filmAimes[1]),
                          ],
                        );

                      });
                    }

                ),

                SizedBox(height: 12.0),
                Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0)
                ),
              ],
            ),
          )
      ),

    );
  }
}