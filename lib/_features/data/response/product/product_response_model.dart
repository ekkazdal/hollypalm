import 'package:hollypalm/_features/data/response/product/product_model.dart';

class ProductResponseModel {
  Products? products;

  ProductResponseModel({this.products});

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) => ProductResponseModel(products: Products.fromJson(json["products"]));
}

class Extensions {
  Cost? cost;

  Extensions({this.cost});

  factory Extensions.fromJson(Map<String, dynamic> json) => Extensions(cost: Cost.fromJson(json["cost"]));

  Map<String, dynamic> toJson() => {"cost": cost?.toJson()};
}

class Cost {
  int? requestedQueryCost;

  Cost({this.requestedQueryCost});

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(requestedQueryCost: json["requestedQueryCost"]);

  Map<String, dynamic> toJson() => {"requestedQueryCost": requestedQueryCost};
}
