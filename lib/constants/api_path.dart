/// CHAT
const getUserConversationList = "/chat/myconversations";
const _startChatEndpoint = "/chat/new";

String startConversationFromListing(int listingId) {
  return _startChatEndpoint + "/" + listingId.toString();
}

String sendMessageFromConversation(int conversationId) {
  return "/chat/" + conversationId.toString() + "/send";
}

String getMessageListUpdatesQuery(int conversation) {
  return "/chat/" + conversation.toString() + "/updates";
}

String getMessageListInRange(int conversation) {
  return "/chat/" + conversation.toString() + "/range";
}

// needs login //

/// -- Commodity -- ///

const getCommodity = "aa";
const getAllCommodity = "/commodity/all";
const getAllDisplayCommodity = "/commodity/all-display";
// needs login //

/// -- Receipt -- ///

const getReceipt = "/transaction/";
const getAllReceipts = "/transaction/all";

/// -- Listing -- ///

const getListing = "/listing/";
const getComodityListings = "/listing/comodity/";

String getBuyRequest(int buyreqeustId) {
  return "/listing/buyrequest/" + buyreqeustId.toString();
}

// needs login //
const createOfferListing = "/listing/newOfferListing";
const createBuyRequest = "/listing/newBuyRequest";

/// -- user auth -- ///

const loginUserEndpoint = "/authentication/login";

/// -- buyer register -- ///

const createBuyerEndpoint = "/buyer/create";

/// -- seller register -- ///

const createSellerEndpoint = "/seller/create";

/// -- user reset password -- ///

const changePasswordEndpoint = "/authentication/changepassword";

/// -- rating -- ///
const ratingEndpoint = "/rating/";
const transactionRatingEndpoint = "/rating/transaction/";

Uri getAppUri(String path, {Map<String, String> queryParameters}) {
  return Uri(
      scheme: "http",
      host: "10.0.2.2",
      port: 8080,
      path: "/api" + path,
      queryParameters: queryParameters);
}
