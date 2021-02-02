import 'package:flutter/material.dart';
import 'package:***REMOVED***/generated/fonts.gen.dart';
import 'package:***REMOVED***/widgets/formfield_auth.dart';

class RegisterUserForm extends StatefulWidget {
  const RegisterUserForm({Key key}) : super(key: key);

  @override
  _RegisterUserFormState createState() => _RegisterUserFormState();
}

class _RegisterUserFormState extends State<RegisterUserForm> {
  final _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;

@override
Widget build(BuildContext context) {
  return Form(
      key: _formKey,
      child: Column(
        //padding: EdgeInsets.symmetric(horizontal: 20.0),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FormFieldAuth(
              title: "Full Name",
              hint: "Enter your full name",
              keyboardType: TextInputType.name,
              isObscured: false,
            ),
            FormFieldAuth(
              title: "Email",
              hint: "Enter your email",
              keyboardType: TextInputType.emailAddress,
              isObscured: false,
            ),
            FormFieldAuth(
              title: "Password",
              hint: "Enter your password",
              keyboardType: TextInputType.text,
              isObscured: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                children: <Widget>[
                  Checkbox(
                      value: _agreedToTOS,
                      onChanged: _setAgreedToTOS
                  ),
                  GestureDetector(
                    onTap: () => _setAgreedToTOS(!_agreedToTOS),
                    child: const Text(
                        'I agree to the Terms of Services and Privacy Policy'
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                const Spacer(),
                OutlineButton(
                  highlightedBorderColor: Colors.black,
                  onPressed: _submittable() ? _submit : null,
                  child: const Text('Register'),
                )
              ],
            )
          ]
      )
  );
}

bool _submittable() {
  return _agreedToTOS;
}

void _submit() {
  _formKey.currentState.validate();
  //TODO: send skjiten tel servern
}

void _setAgreedToTOS(bool newValue) {
  setState(() {
    _agreedToTOS = newValue;
  });
}
}