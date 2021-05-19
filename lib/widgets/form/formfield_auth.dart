import 'package:flutter/material.dart';
import 'package:fishapp/config/themes/theme_config.dart';

/// Build a widget with a title and email
class FormFieldAuth extends StatelessWidget {
  final String title;
  final String hint;
  final String validationMsg;
  final bool isObscured;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final Color labelColor;
  final String initialValue;

  const FormFieldAuth(
      {Key key,
      @required this.title,
      @required this.hint,
      this.isObscured,
      this.validationMsg,
      this.keyboardType,
      this.validator,
      this.onSaved,
      this.labelColor,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 0, 5),
            child: Text(
              this.title,
              style: Theme.of(context).primaryTextTheme.headline4.copyWith(
                    color: this.labelColor ?? Colors.white,
                  ),
            ),
          ),
          TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              hintText: hint,
            ).applyDefaults(Theme.of(context).inputDecorationTheme),
            style: inputTextStyle,
            onSaved: onSaved,
            validator: validator,
            obscureText: isObscured ?? false,
          ),
        ],
      ),
    );
  }
}
