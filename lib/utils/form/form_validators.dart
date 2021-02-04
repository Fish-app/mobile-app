//Taken from https://github.com/recipe-heaven/App

// our lord and saviour https://regex101.com/
import 'package:flutter/cupertino.dart';
import 'package:***REMOVED***/generated/l10n.dart';

final alpha = new RegExp(r'[A-Z]');
final hashtag = new RegExp(r'^(((^| )#([a-zA-Z0-9]+))+ *)*$');
final floatRegex = new RegExp(r'^(\d*(.|,)\d*)$');
final emailRegex =
new RegExp(r'^[a-zA-Z0-9.-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9]{2,64})+$');

String validateTagFeald(String value, BuildContext context) {
  // if valid tag or empty return valid
  if (value.contains(hashtag) || value.length == 0) {
    return null;
  }
  return S.of(context).notATag;
}

String validateFloatInput(String value, BuildContext context) {
  if (value.contains(floatRegex)) {
    return null;
  }
  return S.of(context).notAnumber;
}

String validateNotEmptyInput(String value, BuildContext context) {
  if (value.trim().isNotEmpty) {
    return null;
  } else {
    return S.of(context).notEmpty;
  }
}

String validateEmail(String value, BuildContext context) {
  if (value.trim().contains(emailRegex)) {
    return null;
  } else {
    return S.of(context).validEmail;
  }
}

String validateLength(String value, BuildContext context, {int min = -1, int max = -1}) {
  var invalid = false;
  if (min >= 0) {
    invalid = value.length < min;
  }
  if (max >= 0 && max >= min && !invalid) {
    invalid = value.length > max;
  }
  var errorMessage = "";
  if (min >= 0 && max >= 0 && max >= min) {
    errorMessage = S.of(context).betweenMinMax + " $min " + S.of(context).and +
        " $max " + S.of(context).characters;
  } else if (min >= 0) {
    errorMessage = S.of(context).min + " $min " + S.of(context).characters;
  } else if (max >= 0) {
    errorMessage = S.of(context).max + " $max " + S.of(context).characters;
  }

  return invalid ? errorMessage : null;
}

String validateEquality(String a, String b, String targetEquality, BuildContext context) {
  if (a != b) {
    return S.of(context).notEqual + " $targetEquality";
  }
  return null;
}

/// Runs all validators unless a validation fails. If one fails, return the error
/// message for that validation. Else null is returned if all passes.
String multivalidate(List<String Function()> validators) {
  String message;
  validators.every((element) {
    var validatorResult = element();
    if (validatorResult == null) {
      return true;
    }
    message = validatorResult;
    return false;
  });
  return message;
}
