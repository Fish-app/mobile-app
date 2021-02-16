import 'package:flutter/cupertino.dart';
import 'package:maoyi/entities/commodity.dart';

class GenericRouteData {
  num id;

  GenericRouteData({@required this.id});
}

class LoginReturnRouteData {
  final String path;
  final Object pathParams;

  LoginReturnRouteData(this.path, this.pathParams);
}
