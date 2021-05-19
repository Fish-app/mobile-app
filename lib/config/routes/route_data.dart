/**
 * This class is used to send data between pages, when
 * navigating in the application.
 */
import 'package:flutter/cupertino.dart';

class GenericRouteData {
  num id;

  GenericRouteData({@required this.id});
}

class LoginReturnRouteData {
  final String path;
  final Object pathParams;

  LoginReturnRouteData(this.path, this.pathParams);
}
