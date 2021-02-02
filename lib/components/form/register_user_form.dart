import 'package:flutter/material.dart';
import 'package:maoyi/generated/fonts.gen.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                'Full Name',
                style: TextStyle(fontFamily: FontFamily.playfairDisplay),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: CommonStyle.textFieldStyle(labelTextStr: "Full Name", hintTextStr: "Enter your full name"),
              validator: (String value) {
                if ( value.trim().isEmpty) {
                  return 'Full name is required';
                }
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Email is required';
                }
              },
            ),
            /*TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Password is required';
                }
              },
              obscureText: true,
            ),*/
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

class CommonStyle{
  static InputDecoration textFieldStyle({String labelTextStr="",String hintTextStr=""}) {return InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(10.0, 2.0, 16.0, 2.0),
    labelText: labelTextStr,
    hintText:hintTextStr,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );}
}