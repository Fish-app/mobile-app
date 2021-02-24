import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maoyi/config/themes/theme_config.dart';

class FormFieldNormal extends StatelessWidget {
  final String title;
  final String hint;
  final String validationMsg;
  final bool isObscured;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final Color labelColor;
  final String initialValue;
  final GestureTapCallback onTap;
  final TextEditingController controller;
  final bool readOnly;

  const FormFieldNormal(
      {Key key,
        @required this.title,
        this.hint,
        this.isObscured,
        this.validationMsg,
        this.keyboardType,
        this.validator,
        this.onSaved,
        this.labelColor,
        this.initialValue,
        this.onTap,
        this.readOnly = false,
        this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 20.0)),
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            hintText: hint,
            labelText: title,
          ).applyDefaults(normalFormFieldTheme),
          style: listingInputStyle,
          onSaved: onSaved,
          validator: validator,
          obscureText: isObscured ?? false,
          onTap: onTap,
          controller: controller,
          readOnly: readOnly,
        ),
      ],
    );
  }
  
  
}