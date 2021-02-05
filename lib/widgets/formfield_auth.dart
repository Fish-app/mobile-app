import 'package:flutter/material.dart';
import 'package:***REMOVED***/generated/fonts.gen.dart';

/// Build a widget with a title and email
class FormFieldAuth extends StatefulWidget {
  final String title;
  final String hint;
  final String validationMsg;
  final bool isObscured;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;

  const FormFieldAuth({
    Key key,
    @required this.title,
    @required this.hint,
    this.isObscured,
    this.validationMsg,
    this.keyboardType,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState()  =>  _FormFieldAuthState();
  
}
class _FormFieldAuthState extends State<FormFieldAuth> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              widget.title,
              style: Theme.of(context).primaryTextTheme.headline3.copyWith(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: widget.hint,
            ).applyDefaults(Theme.of(context).inputDecorationTheme),
            onSaved: widget.onSaved,
            validator: widget.validator,
            obscureText: widget.isObscured ?? false,
          ),
        ],
      ),
    );
  }

}
