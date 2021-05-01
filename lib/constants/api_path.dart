// needs login start//
/// CHAT
const GET_USER_CONVERSATION_LIST = "/conversations";
const _START_CHAT_ENDPOINT = "/new";

String startConversationFromListing(int listingId) {
  return _START_CHAT_ENDPOINT + "/" + listingId.toString();
}

String sendMessageFromConversation(int conversationId) {
  return conversationId.toString() + "/send";
}

String getMessageListUpdatesQuery(int conversation) {
  return conversation.toString() + "/updates";
}

/// -- Commodity -- ///
const GET_COMMODITY = "/commodity";
const GET_ALL_COMMODITIES = "/commodity/all";
const GET_ALL_DISPLAY_COMMODITIES = "/commodity/all-display";

/// -- Receipt -- ///
const GET_RECEIPT = "/transaction/"; //TODO: Remove when system is in place
const GET_ALL_RECEIPTS = "/transaction/all";

/// -- Listing -- ///
const GET_LISTING = "/listing/offer";
const GET_COMMODITY_LISTINGS = "/listing/commodity/";
const GET_BUY_REQUEST = "/listing/buy";

const CREATE_OFFER_LISTING = "/listing/offer/new";
const CREATE_BUY_REQUEST = "/listing/buy/new";

// needs login end //

/// -- user auth -- ///
const LOGIN_USER_ENDPOINT = "/authentication/login";

/// -- buyer register -- ///
const CREATE_BUYER_ENDPOINT = "/buyer/create";

/// -- seller register -- ///
const CREATE_SELLER_ENDPOINT = "/seller/create";

/// -- user reset password -- ///
const CHANGE_PASSWORD_ENDPOINT = "/authentication/changepass";

/// -- rating -- ///
const RATING_ENDPOINT = "/rating/";
const TRANSACTION_RATING_ENDPOINT = "/rating/transaction/";

Uri getAppUri(String path, {Map<String, String> queryParameters}) {
  return Uri(
      scheme: "http",
      host: "10.0.2.2",
      //host: "remote-run.uials.no",
      port: 8080,
      path: "/api" + path,
      queryParameters: queryParameters);
}
