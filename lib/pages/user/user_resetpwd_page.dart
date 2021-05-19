import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/pages/user/form_user_resetpwd.dart';
import 'package:fishapp/widgets/nav_widgets/row_topbar_return.dart';
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

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
            TopBarRow(title: capitalize(S.of(context).changePassword)),

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
