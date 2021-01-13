import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final databaseReference = Firestore.instance;

  String email = '';
  String passWord = '';
  String name ='';
  String dropdownValueAge = "16-25";
  String dropdownValueGender = "Femme";
  String gender = '';
  String error = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0.0,
        title: Text('Sign up'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(//Username
                  decoration: InputDecoration(
                    hintText: 'email',
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0)
                    )
                  ),
                  validator: (val) => val.isEmpty ? 'Enter a email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(//Password
                  decoration: InputDecoration(
                      hintText: 'password',
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0)
                      )
                  ),
                  validator: (val) => val.length < 6 ? 'Enter a password 6+ char long' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => passWord = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(//name
                  decoration: InputDecoration(
                      hintText: 'name',
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
                    labelText: 'Age',
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
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                            email: email,
                            password: passWord)
                            .then((currentUser) => Firestore.instance
                            .collection("Users")
                            .document(currentUser.user.uid)
                            .setData({
                          'email': email,
                          'nom': name,
                          'age': dropdownValueAge,
                          'gender': dropdownValueGender,
                        }));
                        }
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
