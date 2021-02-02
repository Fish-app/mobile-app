import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:***REMOVED***/config/routes/routes.dart' as routes;

//TODO: Discuss if navstack shall be cleared when entering login page ?

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/background-oceanview.jpg'),
              fit: BoxFit.cover,
            )),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black12.withOpacity(0.2),
            ),
          ),
            // Source on how to add image:
            // https://stackoverflow.com/a/44183373
            Container(
              child: SafeArea(
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
                    FormFieldAuth(title: "E-mail", hint: "ola@dunk.com", isObscured: false),
                    SizedBox(height: 8.0),
                    FormFieldAuth(title: "Password", hint: "your password", isObscured: true),
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
                            Navigator.pushNamed(context, routes.RouteAuthLogin);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Build a widget with a title and email
class FormFieldAuth extends StatefulWidget {
  final String title;
  final String hint;
  final bool isObscured;

  const FormFieldAuth({
    Key key, this.title, this.hint, this.isObscured,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FormFieldAuthState();
    // TODO: implement createState
    throw UnimplementedError();
  }
}
  class _FormFieldAuthState extends State<FormFieldAuth> {

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        //FIXME: doesnt work
        // maxWidth: MediaQuery.of(context).size.width * 0.45,
        maxWidth: 10.0,
      ),
      decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          TextField(
            decoration: InputDecoration(
                filled: true,
                labelText: widget.hint),
            obscureText: widget.isObscured,
          ),
        ],
      ),
    );
  }

}
