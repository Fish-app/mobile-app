import 'dart:convert';

import 'package:http/http.dart';
import 'package:***REMOVED***/constants/api_path.dart' as apiPaths;
import 'package:***REMOVED***/entities/commodity.dart';
import 'package:***REMOVED***/entities/listing.dart';
import 'package:***REMOVED***/utils/services/***REMOVED***_rest_client.dart';

class CommodityService {
  final ***REMOVED***RestClient _client = ***REMOVED***RestClient();

  Future<Commodity> getCommodity(num id) {
    var response = _client.get(apiPaths.getCommodity);
    return response.then((value) => _getCommodityResultHandler(value));
  }

  Commodity _getCommodityResultHandler(Response response) {
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
  final ***REMOVED***RestClient _client = ***REMOVED***RestClient();

  Future<Listing> getCommodity(num id) {
    var response = _client.get(apiPaths.getListing);
    return response.then((value) => _getListingResultHandler(value));
  }

  Listing _getListingResultHandler(Response response) {
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body["data"] != null) {
        return Listing.fromJson(body["data"]);
      }
    }
    return null;
  }
}
