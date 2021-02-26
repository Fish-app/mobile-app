import 'package:flutter/material.dart';
import 'package:***REMOVED***/entities/user.dart';
import 'package:***REMOVED***/utils/services/auth_service.dart';
import 'package:***REMOVED***/widgets/nav_widgets/floating_nav_bar.dart';
import 'package:***REMOVED***/pages/user/form_user_resetpwd.dart';
import 'package:***REMOVED***/config/routes/routes.dart' as routes;
import 'package:***REMOVED***/widgets/nav_widgets/row_topbar_return.dart';

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
            TopBarRow(title: "Change password"), //TODO: must use localization

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
