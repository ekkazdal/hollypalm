class PriceRange {
  VariantPrice? minVariantPrice;
  VariantPrice? maxVariantPrice;

  PriceRange({this.minVariantPrice, this.maxVariantPrice});

  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(minVariantPrice: VariantPrice.fromJson(json["minVariantPrice"]), maxVariantPrice: VariantPrice.fromJson(json["maxVariantPrice"]));

  Map<String, dynamic> toJson() => {"minVariantPrice": minVariantPrice?.toJson(), "maxVariantPrice": maxVariantPrice?.toJson()};
}

class VariantPrice {
  String? amount;
  String? currencyCode;

  VariantPrice({this.amount, this.currencyCode});

  factory VariantPrice.fromJson(Map<String, dynamic> json) => VariantPrice(amount: json["amount"], currencyCode: json["currencyCode"]);

  Map<String, dynamic> toJson() => {"amount": amount, "currencyCode": currencyCode};
}
