class ListingFormData {
  int endDate;
  int commodityId;
  double price;
  int maxAmount;
  double latitude;
  double longitude;

  toMap() {
    return {
      "endDate" : this.endDate,
      "commodityId" : this.commodityId,
      "price" : this.price,
      "maxAmount" : this.maxAmount,
      "latitude" : this.latitude,
      "longitude" : this.longitude,
    };
  }
}