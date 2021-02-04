import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maoyi/utils/form/register_user_form.dart';
import 'package:maoyi/widgets/logo.dart';
import 'package:maoyi/widgets/stack_blurredbackground.dart';

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


