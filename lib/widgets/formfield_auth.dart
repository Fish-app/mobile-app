import 'package:flutter/material.dart';
import 'package:maoyi/generated/fonts.gen.dart';

/// Build a widget with a title and email
class FormFieldAuth extends StatefulWidget {
  final String title;
  final String hint;
  final String validationMsg;
  final bool isObscured;

  const FormFieldAuth({
    Key key, this.title, this.hint, this.validationMsg, this.isObscured,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FormFieldAuthState();
    // TODO: implement createState
    throw UnimplementedError();
  }
}
class _FormFieldAuthState extends State<FormFieldAuth> {

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        //FIXME: doesnt work
        // maxWidth: MediaQuery.of(context).size.width * 0.45,
        maxWidth: 10.0,
      ),
      decoration: BoxDecoration(
        //border: Border.all(width: 2.0, color: Colors.black)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              widget.title,
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontFamily: FontFamily.playfairDisplay
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.
                all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)
                ),
                filled: true,
                fillColor: Colors.white,
                labelText: widget.hint,
                labelStyle: TextStyle(
                    fontFamily: FontFamily.dosis,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black
                )
            ),
            obscureText: widget.isObscured,
          ),
        ],
      ),
    );
  }

}
