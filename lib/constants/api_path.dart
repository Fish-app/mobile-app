const restApiUrl = "http://10.0.2.2:8080/api";

/// -- user auth -- ///

// needs login //

/// -- Commodity -- ///

const getCommodity = restApiUrl + "aa";
const getAllCommodity = restApiUrl + "/commodity/all";
// needs login //

/// -- Listing -- ///

const getListing = restApiUrl + "aa";

// needs login //
const createOfferListing = restApiUrl + "/listing/newOfferListing";


/// -- user auth -- ///

const loginUserEndpoint = restApiUrl + "/authentication/login";

/// -- user register -- ///

const createUserEndpoint = restApiUrl + "/user/create";

/// -- user reset password ///

const changePasswordEndpoint = restApiUrl + "/authentication/changepassword";
