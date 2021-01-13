import 'package:flutter/material.dart';
import 'package:testfirebase/screens/authenticate/register.dart';
import 'package:testfirebase/services/auth.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String passWord = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[300],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[600],
        elevation: 0.0,
        title: Text('Connexion'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Inscription'),
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
                        borderSide: BorderSide(width: 2.0)
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
                  hintText: 'Mot de passe',
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0)
                  )
                ),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ char long' : null,
                onChanged: (val) {
                  setState(() => passWord = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Valider',
                  style: TextStyle(color: Colors.white),
              ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    dynamic result = _auth.signInWithEmailAndPassword(email, passWord);
                    if(result == null) {
                      setState(() => error = 'Impossible de se connecter avec ces identifiants');
                    }
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
