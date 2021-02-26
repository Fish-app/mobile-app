class ListingFormData {
  String endDate;
  String commodityId;
  String price;
  String maxAmount;
  String latitude;
  String longitude;
  String additionalInfo;


  toMap() {
    return {
      "endDate": this.endDate,
      "commodityId": this.commodityId,
      "price": this.price,
      "maxAmount": this.maxAmount,
      "latitude": this.latitude,
      "longitude": this.longitude,
      "additionalInfo": this.additionalInfo
    };
  }
}