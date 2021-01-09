import 'package:flutter/material.dart';
import 'package:testfirebase/shared/constant.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentName;
  String _uid;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
          Text(
            'Settings',
            style: TextStyle(fontSize: 18.0),
          ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: textInputDecoration,
              validator: (val) => val.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              color: Colors.pink[400],
              child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                print(_currentName);
                print(_uid);
              }
              ),
            ],
        ));
  }
}
