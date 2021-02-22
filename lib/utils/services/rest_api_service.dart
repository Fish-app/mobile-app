import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:***REMOVED***/constants/api_path.dart' as apiPaths;
import 'package:***REMOVED***/entities/commodity.dart';
import 'package:***REMOVED***/entities/listing.dart';
import 'package:***REMOVED***/utils/services/***REMOVED***_rest_client.dart';

class CommodityService {
  final ***REMOVED***RestClient _client = ***REMOVED***RestClient();

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

  Future<List<Commodity>> getAllCommodities(BuildContext context) async {
    var response = await _client.get(context, apiPaths.getAllCommodity, addAuth: false);
    List returnList;

    switch (response.statusCode) {
      case 200:
        //TODO: might need some sort of check for if body is empty
        var body = jsonDecode(response.body);
        returnList = Commodity.fromJsonList(body);
        break;
      case 401:
        throw HttpException(HttpStatus.unauthorized.toString());
        break;
      case 500:
        throw HttpException(HttpStatus.internalServerError.toString());
        break;
      default:
        returnList = List();
        break;
    }
    return returnList;
  }
}

class ListingService {
  final ***REMOVED***RestClient _client = ***REMOVED***RestClient();

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
