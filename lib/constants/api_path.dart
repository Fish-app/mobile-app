/// -- user auth -- ///

// needs login //

/// -- Commodity -- ///

const getCommodity = "aa";
const getAllCommodity = "/commodity/all";
// needs login //

/// -- Listing -- ///

const getListing = "aa";

// needs login //
const createOfferListing = "/listing/newOfferListing";

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

Uri getAppUri(String path, {Map<String, String> queryParameters}) {
  return Uri(
      scheme: "http",
      host: "10.0.2.2",
      port: 8080,
      path: "/api" + path,
      queryParameters: queryParameters);
}
