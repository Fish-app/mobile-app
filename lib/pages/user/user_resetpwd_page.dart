import 'package:flutter/material.dart';
import 'package:maoyi/entities/user.dart';
import 'package:maoyi/utils/services/auth_service.dart';
import 'package:maoyi/widgets/floating_nav_bar.dart';
import 'package:maoyi/widgets/form_user_resetpwd.dart';
import 'package:maoyi/config/routes/routes.dart' as routes;
import 'package:maoyi/widgets/row_topbar_return.dart';

class ChangePasswordPage extends StatefulWidget {
  final _buttonColor = Colors.amber;

  const ChangePasswordPage({Key key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(children: [
            // TOP ROW
            TopBarRow(title: "Change password"),

            // MAIN WINDOW
            Expanded(
              child: ListView(
                children: [
                  ResetPasswordForm(),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
