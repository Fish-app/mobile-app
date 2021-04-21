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
const GET_COMMODITY = "/store/commodity";
const GET_ALL_COMMODITIES = "/store/commodity/all";
const GET_ALL_DISPLAY_COMMODITIES = "/store/commodity/all-display";

/// -- Receipt -- ///
const GET_RECEIPT =
    "/store/transaction/"; //TODO: Remove when system is in place
const GET_ALL_RECEIPTS = "/store/transaction/all";

/// -- Listing -- ///
const GET_LISTING = "/store/listing/offer";
const GET_COMMODITY_LISTINGS = "/store/listing/commodity/";
const GET_BUY_REQUEST = "/store/listing/buy";

const CREATE_OFFER_LISTING = "/store/listing/offer/new";
const CREATE_BUY_REQUEST = "/store/listing/buy/new";

// needs login end //

/// -- user auth -- ///
const LOGIN_USER_ENDPOINT = "/auth/authentication/login";

/// -- buyer register -- ///
const CREATE_BUYER_ENDPOINT = "/user/buyer/create";

/// -- seller register -- ///
const CREATE_SELLER_ENDPOINT = "/user/seller/create";

/// -- user reset password -- ///
const CHANGE_PASSWORD_ENDPOINT = "/authentication/changepass";

/// -- rating -- ///
const RATING_ENDPOINT = "/rating/";
const TRANSACTION_RATING_ENDPOINT = "/rating/transaction/";

/// -- -- ///

const GET_BUYER = "/user/buyer/current";
const GET_SELLER = "/user/seller/current";

/// -- -- ///
const NEW_SUBSCRIPTION_ENDPOINT = "/checkout/new-sub";

Uri getAppUri(String path, {Map<String, String> queryParameters}) {
  return Uri(
      scheme: "http",
      // host: "10.0.2.2",
      host: "remote-run.uials.no",
      port: 80,
      path: "/api" + path,
      queryParameters: queryParameters);
}
