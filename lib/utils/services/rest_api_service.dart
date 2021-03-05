import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fishapp/entities/chat/conversation.dart';
import 'package:fishapp/entities/chat/message.dart';
import 'package:fishapp/entities/chat/messagebody.dart';
import 'package:fishapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:fishapp/constants/api_path.dart' as apiPaths;
import 'package:fishapp/entities/commodity.dart';
import 'package:fishapp/entities/listing.dart';
import 'package:fishapp/utils/services/fishapp_rest_client.dart';

import '../../constants/api_path.dart';
import '../../entities/listing.dart';
import '../../entities/listing.dart';
import '../../entities/listing.dart';
import '../../entities/listing.dart';
import '../../entities/listing.dart';
import '../../entities/listing.dart';

class ConversationService {
  final FishappRestClient _client = FishappRestClient();
  // FIXME: Nordic/unicode charachters is broken

  Future<List<Conversation>> getAllConversations(BuildContext context) async {
    var url =
    apiPaths.getAppUri(apiPaths.getUserConversationList);
    var response = await _client.get(context, url, addAuth: true);

    List<Conversation> conversationList;
    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        conversationList = Conversation.fromJsonList(body);
        break;
      case 401:
        throw HttpException(HttpStatus.unauthorized.toString());
        break;
      case 500:
        throw HttpException(HttpStatus.internalServerError.toString());
        break;
      default:
        conversationList = List();
        break;
    }
    return conversationList;
  }

  //TODO: UNTESTED
  Future<Conversation> startNewConversation(
      BuildContext context, num listingId) async {

    Conversation result = Conversation();
    var url = apiPaths
        .getAppUri(apiPaths.startConversationFromListing(listingId));

    try {
      var response = await _client.post(context, url,
          headers: {'Content-type': "application/json"},
          addAuth: true);
      switch (response.statusCode) {
        case 200:
          var body = jsonDecode(response.body);
          result = Conversation.fromJson(body["data"]);
          break;
        case 304:
          // Fekk 304, chat eksisterer frå før
          // hent/ returner eksisterande chatt i stadenfor her.
          //FIXME: lag funksjon for å hente chatt direkte på server og chaine her
          // eller prøve å cache/finne eksisterande conversation i appen ?
          // kanskje må lage hjelpefunksjon her
          break;
        case 401:
          throw HttpException(HttpStatus.unauthorized.toString());
          break;
        case 500:
        default:
          throw HttpException(HttpStatus.internalServerError.toString());
          break;
      }
    } on IOException catch (e) {
      log("IO failure " + e.toString(), time: DateTime.now());
      throw HttpException("Service unavailable");
    }
    return result;
  }

  Future<Conversation> sendMessageRequest(
      BuildContext context, num conversationId, MessageBody messageBody) async {
    Conversation result;
    var url = apiPaths
        .getAppUri(apiPaths.sendMessageFromConversation(conversationId));

    try {
      var response = await _client.post(context, url,
          headers: {'Content-type': "application/json"},
          body: messageBody.toJsonString(),
          addAuth: true);
      switch (response.statusCode) {
        case 200:
          var body = jsonDecode(response.body);
          result = Conversation.fromJson(body["data"]);
          break;
        case 401:
          throw HttpException(HttpStatus.unauthorized.toString());
          break;
        case 500:
        default:
          throw HttpException(HttpStatus.internalServerError.toString());
        break;
      }
    } on IOException catch (e) {
      log("IO failure " + e.toString(), time: DateTime.now());
      throw HttpException("Service unavailable");
    }
    return result;
  }

  Future<List<Message>> getMessageUpdates(
      BuildContext context, num conversationId, num lastMessageId) async {
    //TODO: add queryparam for lastMessageId to limit list
    var url =
    apiPaths.getAppUri(apiPaths.getMessageListUpdatesQuery(conversationId));
    var response = await _client.get(context, url, addAuth: true);

    List<Message> returnList;
    print("REST: Got status code " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        returnList = Message.fromJsonList(body);
        print("REST: Got conversationslist count " + returnList.length.toString());
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

  //TODO: Implement query parameters and do testing
  Future<List<Message>> _getMessageRange(
      BuildContext context, num conversationId, num fromId, num offsetInList) async {
    var url =
        apiPaths.getAppUri(apiPaths.getMessageListInRange(conversationId));
    var response = await _client.get(context, url, addAuth: true);

    List<Message> returnList;

    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        returnList = Message.fromJsonList(body);
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

class CommodityService {
  final FishappRestClient _client = FishappRestClient();

  Future<Commodity> getCommodity(BuildContext context, num id) async {
    var uri = getAppUri(apiPaths.getCommodity);
    var response = await _client.get(context, uri, addAuth: false);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body["data"] != null) {
        return Commodity.fromJson(body["data"]);
      }
    }
    return null;
  }

  Future<List<Commodity>> getAllCommodities(BuildContext context) async {
    var uri = getAppUri(apiPaths.getAllCommodity);
    var response = await _client.get(context, uri, addAuth: false);
    List returnList;

    switch (response.statusCode) {
      case 200:
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

class RatingService {
  final FishappRestClient _client = FishappRestClient();

  Future<num> getRating(BuildContext context, num id) async {
    var uri = getAppUri(apiPaths.ratingEndpoint + id.toString());
    var response = await _client.get(context, uri);

    if (response.statusCode == 200) {
      return num.parse(response.body);
    }
    return null;
  }
}

class ListingService {
  final FishappRestClient _client = FishappRestClient();

  Future<OfferListing> getOfferListing(BuildContext context, num id) async {
    var uri = getAppUri(apiPaths.getListing + id.toString());
    var response = await _client.get(context, uri, addAuth: false);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body["data"] != null) {
        return OfferListing.fromJson(body["data"]);
      }
    }
    return null;
  }

  Future<List<OfferListing>> getCommodityOfferListing(
      BuildContext context, num id) async {
    var uri = getAppUri(apiPaths.getComodityListings + id.toString());
    var response = await _client.get(context, uri, addAuth: false);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<OfferListing> offerListings = List();
      for (var offerListing in body) {
        offerListings.add(OfferListing.fromJson(offerListing));
      }
      return offerListings;
    }
    return null;
  }

  Future<OfferListing> createOfferListing(
      BuildContext context, OfferListing offerListing) async {
    var uri = getAppUri(apiPaths.createOfferListing);
    try {
      var response = await _client.post(context, uri,
          headers: {'Content-type': "application/json"},
          body: offerListing.toJsonString(),
          addAuth: true);
      switch (response.statusCode) {
        case 200:
          return offerListing =
              OfferListing.fromJson(jsonDecode(response.body));
          break;
        case 401:
          throw HttpException(HttpStatus.unauthorized.toString());
          break;
        case 403:
          throw HttpException(HttpStatus.forbidden.toString());
          break;
        case 409:
          break;
        case 500:
        default:
          throw HttpException(HttpStatus.internalServerError.toString());
          break;
      }
    } on IOException catch (e) {
      log("IO failure " + e.toString(), time: DateTime.now());
      throw HttpException("Service unavailable");
    }
    return offerListing;
  }

  Future<BuyRequest> createBuyRequest(
      BuildContext context, BuyRequest buyRequest) async {
    var uri = apiPaths.getAppUri(apiPaths.createBuyRequest);
    try {
      var response = await _client.post(context, uri,
          headers: {'Content-type': "application/json"},
          body: buyRequest.toJsonString(),
          addAuth: true);
      switch (response.statusCode) {
        case 200:
          return buyRequest = BuyRequest.fromJson(jsonDecode(response.body));
          break;
        case 401:
          throw HttpException(HttpStatus.unauthorized.toString());
          break;
        case 403:
          throw HttpException(HttpStatus.forbidden.toString());
          break;
        case 409:
          break;
        case 500:
        default:
          throw HttpException(HttpStatus.internalServerError.toString());
          break;
      }
    } on IOException catch (e) {
      log("IO failure " + e.toString(), time: DateTime.now());
      throw HttpException("Service unavailable");
    }
    return buyRequest;
  }
}
