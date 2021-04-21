import 'dart:convert';
import 'dart:io';

import 'package:fishapp/constants/api_path.dart';
import 'package:fishapp/constants/api_path.dart' as apiPaths;
import 'package:fishapp/entities/subscription.dart';

import 'fishapp_rest_client.dart';

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
}
