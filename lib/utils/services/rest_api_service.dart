import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:maoyi/constants/api_path.dart' as apiPaths;
import 'package:maoyi/entities/commodity.dart';
import 'package:maoyi/entities/listing.dart';
import 'package:maoyi/utils/services/maoyi_rest_client.dart';

class CommodityService {
  final MaoyiRestClient _client = MaoyiRestClient();

  Future<Commodity> getCommodity(BuildContext context, num id) async {
    var response = await _client.get(context, apiPaths.getCommodity);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body["data"] != null) {
        return Commodity.fromJson(body["data"]);
      }
    }
    return null;
  }
}

class ListingService {
  final MaoyiRestClient _client = MaoyiRestClient();

  Future<Listing> getCommodity(BuildContext context, num id) async {
    var response = await _client.get(context, apiPaths.getListing);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body["data"] != null) {
        return Listing.fromJson(body["data"]);
      }
    }
    return null;
  }
}
