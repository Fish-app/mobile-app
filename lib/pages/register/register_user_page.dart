import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:***REMOVED***/utils/form/register_user_form.dart';
import 'package:***REMOVED***/widgets/logo.dart';
import 'package:***REMOVED***/widgets/stack_blurredbackground.dart';

class RegisterUserPage extends StatefulWidget {
  RegisterUserPage({Key key}) : super(key: key);


  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StackBlurredBackground(
        AssetImage('assets/images/background-oceanview.jpg'),
        Container(
          //Solution for scrolling fields while background is locked
          //Found on https://stackoverflow.com/questions/65622166/background-image-is-moving-when-keyboards-appears-flutter
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              children: <Widget>[
                SizedBox(
                  height: 52.0,
                ),
                Column(
                  children: [
                    Logo(),
                  ],
                ),
                RegisterUserForm(),
              ],
            ),
          ),
        )
      ),
    );
  }
}




