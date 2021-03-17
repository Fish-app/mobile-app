import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fishapp/config/themes/theme_config.dart';

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
  final String suffixText;
  final EdgeInsets padding;

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
      this.controller,
      this.suffixText,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: padding ?? EdgeInsets.zero,
          child: TextFormField(
            keyboardType: keyboardType,
            initialValue: initialValue,
            decoration: InputDecoration(
              suffixText: suffixText,
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
        ),
      ],
    );
  }
}
