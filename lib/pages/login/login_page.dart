import 'package:flutter/material.dart';

//TODO: Discuss if navstack shall be cleared when entering login page ?

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            SizedBox(
              height: 52.0,
            ), // Spacing between top and header
            Column(
              children: [
                Text(
                  "Mayoi",
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            // Spacing between header and login fields
            SizedBox(height: 148.0),
            Container(
              constraints: BoxConstraints(
                //FIXME: doesnt work
                // maxWidth: MediaQuery.of(context).size.width * 0.45,
                maxWidth: 10.0,
              ),
              width: 100.0, // FIXME: Doesnt work
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.black)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Email',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        filled: true, labelText: 'dwight@shrutefarms.com'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.black),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Password',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        filled: true, labelText: 'your password here'),
                    obscureText: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 48.0),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RaisedButton(
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 32.0),
                  ),
                  onPressed: () {
                    //TODO: Implement login call and clear nav stack ?
                  },
                ),
                SizedBox(height: 48.0),
                FlatButton(
                  child: Text(
                    'Create new user',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  onPressed: () {
                    //TODO: Implement new user
                    Navigator.pushNamed(context, '/user/login');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
