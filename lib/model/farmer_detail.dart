class FarmerDetails {
  final String farmerUid;
  final String? situation;
  final String? business;
  final String? productFocused;
  final String? productNature;
  final String? package;
  final String? region;
  final String? delivery;

  FarmerDetails({
    required this.farmerUid,
    this.situation,
    this.business,
    this.productFocused,
    this.productNature,
    this.package,
    this.region,
    this.delivery,
  });


  Map<String, dynamic> toJson() {
    return {
      'farmerUid': farmerUid,
      'situation': situation,
      'business': business,
      'productFocused': productFocused,
      'productNature': productNature,
      'package': package,
      'region': region,
      'delivery': delivery,
    };
  }


}
