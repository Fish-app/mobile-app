import 'dart:convert';
import 'dart:io';

import 'package:fishapp/constants/api_path.dart';
import 'package:fishapp/constants/api_path.dart' as apiPaths;
import 'package:fishapp/entities/subscription.dart';
import 'package:string_validator/string_validator.dart';

import 'fishapp_rest_client.dart';

///
/// This class exposes a REST Client for the
/// authentication part of the app.
///
class SubscriptionService {
  final FishappRestClient _client = FishappRestClient();

  Future<NewSubscription> getNewSubscription() async {
    var uri = getAppUri(apiPaths.NEW_SUBSCRIPTION_ENDPOINT);
    var response =
        await _client.get(uri, addAuth: true, contentType: ContentType.json);

    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);
      return NewSubscription.fromJson(body);
    } else {
      ApiException(response).dump();
    }
    return null;
  }

  Future<String> getSubscriptionStatus(num id) async {
    var uri = getAppUri(apiPaths.SUBSCRIPTION_STATUS_ENDPOINT + id.toString());
    var response =
        await _client.get(uri, addAuth: true, contentType: ContentType.text);

    if (response.statusCode == HttpStatus.accepted) {
      var subStatus = response.body;
      return subStatus;
    } else {
      ApiException(response).dump();
    }
    return "";
  }

  Future<bool> getIsSubscriptionValid(num id) async {
    var uri =
        getAppUri(apiPaths.IS_SUBSCRIPTION_VALID_ENDPOINT + id.toString());
    var response =
        await _client.get(uri, addAuth: true, contentType: ContentType.text);

    if (response.statusCode == HttpStatus.accepted) {
      var isValid = toBoolean(response.body, true);
      return isValid;
    } else {
      ApiException(response).dump();
    }
    return false;
  }

  Future<bool> cancelSubscription() async {
    var uri = getAppUri(apiPaths.CANCEL_SUBSCRIPTION_ENDPOINT);
    var response = await _client.get(uri, addAuth: true);

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      ApiException(response).dump();
    }
    return false;
  }
}
