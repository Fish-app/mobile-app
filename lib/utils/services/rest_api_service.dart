import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fishapp/entities/chat/conversation.dart';
import 'package:fishapp/entities/chat/message.dart';
import 'package:fishapp/entities/chat/messagebody.dart';
import 'package:flutter/cupertino.dart';
import 'package:fishapp/constants/api_path.dart' as apiPaths;
import 'package:fishapp/entities/commodity.dart';
import 'package:fishapp/entities/listing.dart';
import 'package:fishapp/utils/services/fishapp_rest_client.dart';

import '../../constants/api_path.dart';
import '../../entities/listing.dart';

class ConversationService {
  final FishappRestClient _client = FishappRestClient();

  Future<List<Conversation>> getAllConversations(
      BuildContext context, bool includeLastMsg) async {
    Map<String, String> queryParameters;
    if (includeLastMsg != null) {
      queryParameters = {'include-lastmessage': includeLastMsg.toString()};
    }
    var url = apiPaths.getAppUri(apiPaths.getUserConversationList,
        queryParameters: queryParameters);
    var response = await _client.get(context, url, addAuth: true);

    List<Conversation> conversationList = List();

    if (response.statusCode == HttpStatus.ok) {
      if (response.body.isNotEmpty) {
        var body = jsonDecode(response.body);
        conversationList = Conversation.fromJsonList(body);
      } else {
        throw ApiException(response);
      }
    }
    return conversationList;
  }

  Future<Conversation> startNewConversation(
      BuildContext context, num listingId) async {
    Conversation result = Conversation();
    var url =
        apiPaths.getAppUri(apiPaths.startConversationFromListing(listingId));

    try {
      var response = await _client.post(context, url,
          headers: {'Content-type': "application/json"}, addAuth: true);
      print('REST: Fetch conversation: ' + response.statusCode.toString());

      if (response.statusCode == HttpStatus.ok) {
        var responseBody = jsonDecode(response.body);
        result = Conversation.fromJson(responseBody);
      } else {
        throw ApiException(response);
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
          headers: {'Content-type': "application/json; charset=UTF-8"},
          body: messageBody.toJsonString(),
          addAuth: true);

      if (response.statusCode == HttpStatus.ok) {
        var responseBody = jsonDecode(response.body);
        result = Conversation.fromJson(responseBody);
      } else {
        throw ApiException(response);
      }
    } on IOException catch (e) {
      log("IO failure " + e.toString(), time: DateTime.now());
      throw HttpException("Service unavailable");
    }
    return result;
  }

  Future<List<Message>> getMessageUpdates(
      BuildContext context, num conversationId, num lastMessageId) async {
    Map<String, String> queryParameters;
    if (lastMessageId != null) {
      queryParameters = {'last-id': lastMessageId.toString()};
    }
    var url = apiPaths.getAppUri(
        apiPaths.getMessageListUpdatesQuery(conversationId),
        queryParameters: queryParameters);
    var response = await _client.get(context, url, addAuth: true);

    List<Message> returnList = List();
    print("REST: Message updates GOT " + response.statusCode.toString());

    if (response.statusCode == HttpStatus.ok) {
      if (response.body.isNotEmpty) {
        var body = jsonDecode(response.body);
        returnList = Message.fromJsonList(body);
        print("REST: Parsed " +
            returnList.length.toString() +
            " messages to list");
      }
    } else {
      throw ApiException(response);
    }
    return returnList;
  }

  //TODO: untested and not currently used, also needs to be checked on server before use
  Future<List<Message>> _getMessageRange(BuildContext context,
      num conversationId, num fromId, num offsetInList) async {
    Map<String, String> queryParameters;
    if (fromId != null && offsetInList != null) {
      queryParameters = {
        'from': fromId.toString(),
        'offset': offsetInList.toString(),
      };
    }
    var url = apiPaths.getAppUri(apiPaths.getMessageListInRange(conversationId),
        queryParameters: queryParameters);
    var response = await _client.get(context, url, addAuth: true);

    List<Message> returnList = List();

    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);
      returnList = Message.fromJsonList(body);
    } else {
      throw ApiException(response);
    }
    return returnList;
  }
}

class CommodityService {
  final FishappRestClient _client = FishappRestClient();

  Future<Commodity> getCommodity(BuildContext context, num id) async {
    var uri = getAppUri(apiPaths.getCommodity);
    var response = await _client.get(context, uri, addAuth: false);

    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);
      if (body["data"] != null) {
        return Commodity.fromJson(body["data"]);
      }
    } else {
      throw ApiException(response);
    }
    return null;
  }

  Future<List<Commodity>> getAllCommodities(BuildContext context) async {
    var uri = getAppUri(apiPaths.getAllCommodity);
    var response = await _client.get(context, uri, addAuth: false);
    List returnList;
    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);
      returnList = Commodity.fromJsonList(body);
    } else {
      throw ApiException(response);
    }
    return returnList;
  }
}

class RatingService {
  final FishappRestClient _client = FishappRestClient();

  Future<num> getRating(BuildContext context, num id) async {
    var uri = getAppUri(apiPaths.ratingEndpoint + id.toString());
    var response = await _client.get(context, uri);

    if (response.statusCode == HttpStatus.ok) {
      return num.parse(response.body);
    } else {
      throw ApiException(response);
    }
  }
}

class ListingService {
  final FishappRestClient _client = FishappRestClient();

  Future<OfferListing> getOfferListing(BuildContext context, num id) async {
    var uri = getAppUri(apiPaths.getListing + id.toString());
    var response = await _client.get(context, uri, addAuth: false);

    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);
      if (body["data"] != null) {
        return OfferListing.fromJson(body["data"]);
      }
    } else {
      throw ApiException(response);
    }
    return null;
  }

  Future<List<OfferListing>> getCommodityOfferListing(
      BuildContext context, num id) async {
    var uri = getAppUri(apiPaths.getComodityListings + id.toString());
    var response = await _client.get(context, uri, addAuth: false);

    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);
      List<OfferListing> offerListings = List();
      for (var offerListing in body) {
        offerListings.add(OfferListing.fromJson(offerListing));
      }
      return offerListings;
    } else {
      throw ApiException(response);
    }
  }

  Future<OfferListing> createOfferListing(
      BuildContext context, OfferListing offerListing) async {
    var uri = getAppUri(apiPaths.createOfferListing);
    var response = await _client.post(context, uri,
        headers: {'Content-type': "application/json"},
        body: offerListing.toJsonString(),
        addAuth: true);

    if (response.statusCode == HttpStatus.ok) {
      return offerListing = OfferListing.fromJson(jsonDecode(response.body));
    } else {
      throw ApiException(response);
    }
  }

  Future<BuyRequest> createBuyRequest(
      BuildContext context, BuyRequest buyRequest) async {
    var uri = apiPaths.getAppUri(apiPaths.createBuyRequest);
    var response = await _client.post(context, uri,
        headers: {'Content-type': "application/json"},
        body: buyRequest.toJsonString(),
        addAuth: true);
    if (response.statusCode == HttpStatus.ok) {
      return buyRequest = BuyRequest.fromJson(jsonDecode(response.body));
    } else {
      throw ApiException(response);
    }
  }

  Future<BuyRequest> getBuyRequest(BuildContext context, num id) async {
    var uri = getAppUri(apiPaths.getBuyRequest(id));
    var response = await _client.get(context, uri, addAuth: false);

    print('REST: Buy request got ' + response.statusCode.toString());
    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);
      if (body["data"] != null) {
        return BuyRequest.fromJson(body["data"]);
      }
    } else {
      throw ApiException(response);
    }
    return null;
  }
}
