///
/// This class specifies the REST API-endpoints on the
/// server. The endpoints are grouped by the
/// microservices on the server.
///

/// AUTH ///
const CHANGE_PASSWORD_ENDPOINT = "/auth/authentication/changepass";
const LOGIN_USER_ENDPOINT = "/auth/authentication/login";

/// CHAT ///
const GET_USER_CONVERSATION_LIST = "/chat/conversations";

String startConversationFromListing(int listingId) {
  return "/chat/new/" + listingId.toString();
}

String sendMessageFromConversation(int conversationId) {
  return "/chat/" + conversationId.toString() + "/send";
}

String getMessageListUpdatesQuery(int conversation) {
  return "/chat/" + conversation.toString() + "/updates";
}

/// CHECKOUT ///
const NEW_SUBSCRIPTION_ENDPOINT = "/checkout/new-sub";
const IS_SUBSCRIPTION_VALID_ENDPOINT = "/checkout/subscription/valid/";
const CANCEL_SUBSCRIPTION_ENDPOINT = "/checkout/subscription/cancel";
const SUBSCRIPTION_STATUS_ENDPOINT = "/checkout/subscription/status/";

/// MEDIA ///
/// STORE ///
// Commodities
const GET_COMMODITY = "/store/commodity";
const GET_ALL_COMMODITIES = "/store/commodity/all";
const GET_ALL_DISPLAY_COMMODITIES = "/store/commodity/all-display";
// Listings
const GET_LISTING = "/store/listing/offer/";
const GET_BUY_REQUEST = "/store/listing/buy/";
const GET_COMMODITY_LISTINGS = "/store/listing/commodity/";
const CREATE_OFFER_LISTING = "/store/listing/offer/new";
const CREATE_BUY_REQUEST = "/store/listing/buy/new";
// Rating
const RATING_ENDPOINT = "/store/rating/";
const TRANSACTION_RATING_ENDPOINT = "/store/rating/transaction/";
// Receipt
const GET_RECEIPT = "/store/transaction/";
const GET_ALL_RECEIPTS = "/store/transaction/all";

/// USER ///
const GET_SPESIFIC_SELLER = "/user/buyer/current";
const GET_BUYER = "/user/buyer/current";
const GET_SELLER = "/user/seller/current";

const CREATE_BUYER_ENDPOINT = "/user/buyer/create";
const CREATE_SELLER_ENDPOINT = "/user/seller/create";

/// COMMON SERVER URL ///
Uri getAppUri(String path, {Map<String, String> queryParameters}) {
  return Uri(
      //LOCAL
      scheme: "http",
      host: "10.0.2.2",
      port: 8080,
      //scheme: "https",
      //host: "pc-1.uials.no",
      path: "/api" + path,
      queryParameters: queryParameters);
}
