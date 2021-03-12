import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fishapp/constants/api_path.dart' as apiPaths;
import 'package:fishapp/entities/chat/conversation.dart';
import 'package:fishapp/entities/chat/message.dart';
import 'package:fishapp/entities/chat/messagebody.dart';
import 'package:fishapp/entities/commodity.dart';
import 'package:fishapp/entities/listing.dart';
import 'package:fishapp/entities/receipt.dart';
import 'package:fishapp/utils/services/fishapp_rest_client.dart';
import 'package:flutter/cupertino.dart';

import '../../constants/api_path.dart';
import '../../entities/listing.dart';

class ReceiptService {
  final FishappRestClient _client = FishappRestClient();

  // TODO: remove when system is in place
  Future<Receipt> newOrder(num id, int amount) async {
    var uri = getAppUri(apiPaths.getReceipt);
    var response = await _client.post(uri,
        addAuth: true,
        contentType: ContentType.json,
        body: NewOrder(amount: amount, listingId: id).toJsonString());

    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);
      return Receipt.fromJson(body);
    } else {
      ApiException(response).dump();
    }
    return null;
  }

  Future<Receipt> getReceipt(num id) async {
    var uri = getAppUri(apiPaths.getReceipt + id.toString());

    var response = await _client.get(uri, addAuth: false);

    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);
      if (body["data"] != null) {
        return Receipt.fromJson(body["data"]);
      }
    } else {
      throw ApiException(response);
    }
    return null;
  }

  Future<List<Receipt>> getAllUserReceipt(BuildContext context) async {
    var url = apiPaths.getAppUri(apiPaths.getAllReceipts);
    var response = await _client.get(url, addAuth: true);

    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);
      List<Receipt> offerListings = List();
      for (var receipt in body) {
        offerListings.add(Receipt.fromJson(receipt));
      }
      return offerListings;
    } else {
      throw ApiException(response);
    }
  }
}

class ConversationService {
  final FishappRestClient _client = FishappRestClient();

  final bool _debug = false;

  Future<List<Conversation>> getAllConversations({bool includeLastMsg}) async {
    Map<String, String> queryParameters;
    if (includeLastMsg != null) {
      queryParameters = {'include-lastmessage': includeLastMsg.toString()};
    }
    var url = apiPaths.getAppUri(apiPaths.getUserConversationList,
        queryParameters: queryParameters);
    var response = await _client.get(url, addAuth: true);

    List<Conversation> conversationList = List();

    print(response.statusCode.toString());
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

  Future<Conversation> startNewConversation(num listingId) async {
    Conversation result = Conversation();
    var url =
        apiPaths.getAppUri(apiPaths.startConversationFromListing(listingId));

    try {
      var response =
          await _client.post(url, contentType: ContentType.json, addAuth: true);
      if (this._debug)
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
      num conversationId, MessageBody messageBody) async {
    Conversation result;
    var url = apiPaths
        .getAppUri(apiPaths.sendMessageFromConversation(conversationId));

    try {
      var response = await _client.post(url,
          contentType: ContentType.json,
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
      num conversationId, num lastMessageId) async {
    Map<String, String> queryParameters;
    if (lastMessageId != null) {
      queryParameters = {'last-id': lastMessageId.toString()};
    }
    var url = apiPaths.getAppUri(
        apiPaths.getMessageListUpdatesQuery(conversationId),
        queryParameters: queryParameters);
    var response = await _client.get(url, addAuth: true);

    List<Message> returnList = List();
    if (this._debug)
      print("REST: Message updates GOT " + response.statusCode.toString());

    if (response.statusCode == HttpStatus.ok) {
      if (response.body.isNotEmpty) {
        var body = jsonDecode(response.body);
        returnList = Message.fromJsonList(body);
        if (this._debug)
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
  Future<List<Message>> _getMessageRange(
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
    var response = await _client.get(url, addAuth: true);

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

  Future<Commodity> getCommodity(num id) async {
    var uri = getAppUri(apiPaths.getCommodity);
    var response = await _client.get(uri, addAuth: false);

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

  Future<List<Commodity>> getAllCommodities() async {
    var uri = getAppUri(apiPaths.getAllCommodity);
    var response = await _client.get(uri, addAuth: false);
    List returnList;
    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);
      returnList = Commodity.fromJsonList(body);
    } else {
      throw ApiException(response);
    }
    return returnList;
  }

  Future<List<DisplayCommodity>> getAllDisplayCommodities() async {
    var uri = getAppUri(apiPaths.getAllDisplayCommodity);
    var response = await _client.get(uri, addAuth: false);
    List returnList;
    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);
      returnList = DisplayCommodity.fromJsonList(body);
    } else {
      ApiException(response).dump();
    }
    return returnList;
  }
}

class RatingService {
  final FishappRestClient _client = FishappRestClient();

  Future<num> getUserRating(num id) async {
    var uri = getAppUri(apiPaths.ratingEndpoint + id.toString());
    var response = await _client.get(uri, addAuth: true);

    if (response.statusCode == HttpStatus.ok) {
      return num.tryParse(response.body) ?? -1;
    } else {
      throw ApiException(response);
    }
  }

  Future<num> getUserTransactionRating(num id) async {
    var uri =
        getAppUri(apiPaths.transactionRatingEndpoint + id.floor().toString());
    var response = await _client.get(uri, addAuth: true);

    if (response.statusCode == HttpStatus.ok) {
      return num.tryParse(response.body) ?? -1;
    } else {
      //throw ApiException(response);
      print(response.statusCode);
      print(response.request.url);
    }
  }

  Future<num> newRating(num transactionId, int stars) async {
    var uri = getAppUri(apiPaths.ratingEndpoint, queryParameters: {
      "transactionid": transactionId.round().toString(),
      "stars": stars.toString()
    });
    var response = await _client.post(uri, addAuth: true);

    if (response.statusCode == HttpStatus.ok) {
      return num.tryParse(response.body) ?? -1;
    } else {
      //throw ApiException(response);
      print(response.statusCode);
      print(response.request.url);
    }
  }
}

class ListingService {
  final FishappRestClient _client = FishappRestClient();

  final bool _debug = false;

  Future<OfferListing> getOfferListing(num id) async {
    var uri = getAppUri(apiPaths.getListing + id.toString());
    var response = await _client.get(uri, addAuth: false);

    if (response.statusCode == HttpStatus.ok) {
      var body = jsonDecode(response.body);
      if (body != null) {
        return OfferListing.fromJson(body);
      } else {
        throw ApiException(response);
      }
    } else {
      throw ApiException(response);
    }
    return null;
  }

  Future<List<OfferListing>> getCommodityOfferListing(num id) async {
    var uri = getAppUri(apiPaths.getComodityListings + id.toString());
    var response = await _client.get(uri, addAuth: false);

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

  Future<OfferListing> createOfferListing(OfferListing offerListing) async {
    var uri = getAppUri(apiPaths.createOfferListing);
    var response = await _client.post(uri,
        contentType: ContentType.json,
        body: offerListing.toJsonString(),
        addAuth: true);

    if (response.statusCode == HttpStatus.ok) {
      return offerListing = OfferListing.fromJson(jsonDecode(response.body));
    } else {
      throw ApiException(response);
    }
  }

  Future<BuyRequest> createBuyRequest(BuyRequest buyRequest) async {
    var uri = apiPaths.getAppUri(apiPaths.createBuyRequest);
    var response = await _client.post(uri,
        contentType: ContentType.json,
        body: buyRequest.toJsonString(),
        addAuth: true);
    if (response.statusCode == HttpStatus.ok) {
      return buyRequest = BuyRequest.fromJson(jsonDecode(response.body));
    } else {
      throw ApiException(response);
    }
  }

  Future<BuyRequest> getBuyRequest(num id) async {
    if (this._debug) print('REST: Ask for buy request ' + id.toString());
    var uri = getAppUri(apiPaths.getBuyRequest(id));
    var response = await _client.get(uri, addAuth: false);

    BuyRequest result;
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(response.body);
      result = BuyRequest.fromJson(responseBody);
    } else {
      throw ApiException(response);
    }
    return result;
  }
}
