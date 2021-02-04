import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maoyi/widgets/register_user_form.dart';
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
      body: BlurredBackgroundWidget(
        backgroundImage: AssetImage('assets/images/background-oceanview.jpg'),
        container: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              children: [
                SizedBox(
                  height: 52.0,
                ),
                Align(alignment: Alignment.center, child: Logo()),
                RegisterUserForm(),
              ],
            ),
          ),
        )
      ),
    );
  }
}



