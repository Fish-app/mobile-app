import 'package:fishapp/config/routes/route_data.dart';
import 'package:fishapp/config/routes/routes.dart' as routes;
import 'package:fishapp/entities/seller.dart';
import 'package:fishapp/entities/user.dart';
import 'package:fishapp/generated/l10n.dart';
import 'package:fishapp/utils/form/form_validators.dart';
import 'package:fishapp/utils/services/auth_service.dart';
import 'package:fishapp/utils/services/fishapp_rest_client.dart';
import 'package:fishapp/widgets/form/formfield_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

class RegisterSellerForm extends StatefulWidget {
  final LoginReturnRouteData returnRoute;
  final authService = AuthService();

  RegisterSellerForm({Key key, this.returnRoute}) : super(key: key);

  @override
  _RegisterSellerFormState createState() => _RegisterSellerFormState();
}

class _RegisterSellerFormState extends State<RegisterSellerForm> {
  final _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = false;
  SellerNewData _sellerNewData;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _sellerNewData = SellerNewData();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormFieldAuth(
                initialValue: "tests",
                title: S.of(context).name,
                hint: S.of(context).fullName,
                keyboardType: TextInputType.name,
                onSaved: (newValue) => {_sellerNewData.name = newValue},
                validator: (value) {
                  return validateNotEmptyInput(value, context);
                },
              ),
              FormFieldAuth(
                initialValue: "tests@example.com",
                title: capitalize(S.of(context).email),
                hint: S.of(context).emailHint,
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => {_sellerNewData.userName = newValue},
                validator: (value) {
                  return validateEmail(value, context);
                },
              ),
              FormFieldAuth(
                initialValue: "123456789",
                title: capitalize(S.of(context).regNumber),
                hint: S.of(context).regNumberHint,
                keyboardType: TextInputType.number,
                onSaved: (newValue) => {_sellerNewData.regNumber = newValue},
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return S.of(context).notEmpty;
                  } else {
                    return validateIntInput(value, context);
                  }
                },
              ),
              FormFieldAuth(
                initialValue: "12345678",
                title: capitalize(S.of(context).password),
                hint: S.of(context).passwordHint,
                keyboardType: TextInputType.text,
                onSaved: (newValue) => {_sellerNewData.password = newValue},
                validator: (value) {
                  return validateLength(value, context, min: 8);
                },
                isObscured: true,
              ),
              FormFieldAuth(
                initialValue: "12345678",
                title: S.of(context).confirmPassword,
                hint: S.of(context).confirmPasswordHint,
                keyboardType: TextInputType.text,
                validator: (value) {
                  return validateEquality(value, _sellerNewData.password,
                      S.of(context).password, context);
                },
                isObscured: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Checkbox(value: _agreedToTOS, onChanged: _setAgreedToTOS),
                    GestureDetector(
                      onTap: () => _setAgreedToTOS(!_agreedToTOS),
                      child: Text(
                        S.of(context).tos,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style.copyWith(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10))),
                    onPressed: () {
                      if (_agreedToTOS) {
                        _handleRegister(context);
                      }
                    },
                    child: Text(
                      S.of(context).createUser.toUpperCase(),
                      style: Theme.of(context).primaryTextTheme.headline5,
                    )),
              ),
              Text(
                _errorMessage,
                style: TextStyle(color: Theme.of(context).errorColor),
              )
            ],
          ),
        ));
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }

  void _handleRegister(BuildContext context) async {
    print(widget.returnRoute?.path);
    final FormState formState = _formKey.currentState;
    setState(() {
      _errorMessage = "";
    });
    formState.save();
    if (formState.validate()) {
      try {
        await widget.authService.createSeller(_sellerNewData);
        var suc = await widget.authService.loginUser(UserLoginData(
            userName: _sellerNewData.userName,
            password: _sellerNewData.password));
        if (suc) {
          Navigator.removeRouteBelow(context, ModalRoute.of(context));
          Navigator.popAndPushNamed(
              context, widget.returnRoute?.path ?? routes.HOME,
              arguments: widget.returnRoute?.pathParams);
        }
      } on ApiException catch (e) {
        setState(() {
          //TODO: om bruker allerede eksisterer burde man få beskjed om det
          _errorMessage = e.toString();
        });
      }
    }
  }
}
