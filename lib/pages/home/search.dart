import 'package:flutter/material.dart';

class SearchState extends ChangeNotifier {
  String _searchString;

  SearchState() {
    _searchString = "";
  }

  set searchString(String searchString) {
    _searchString = searchString;
    notifyListeners();
  }

  String get searchString => _searchString;
}
