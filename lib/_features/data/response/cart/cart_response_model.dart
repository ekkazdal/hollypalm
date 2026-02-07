// To parse this JSON data, do
//
//     final cartResponseModel = cartResponseModelFromJson(jsonString);

import 'dart:convert';

CartResponseModel cartResponseModelFromJson(String str) => CartResponseModel.fromJson(json.decode(str));

String cartResponseModelToJson(CartResponseModel data) => json.encode(data.toJson());

class CartResponseModel {
  Cart? cart;

  CartResponseModel({this.cart});

  factory CartResponseModel.fromJson(Map<String, dynamic> json) => CartResponseModel(cart: Cart.fromJson(json["cart"]));

  Map<String, dynamic> toJson() => {"cart": cart!.toJson()};
}

class Cart {
  String? checkoutUrl;
  DateTime? createdAt;
  String? id;
  String? note;
  int? totalQuantity;
  DateTime? updatedAt;

  Cart({this.checkoutUrl, this.createdAt, this.id, this.note, this.totalQuantity, this.updatedAt});

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(checkoutUrl: json["checkoutUrl"], createdAt: DateTime.parse(json["createdAt"]), id: json["id"], note: json["note"], totalQuantity: json["totalQuantity"], updatedAt: DateTime.parse(json["updatedAt"]));

  Map<String, dynamic> toJson() => {"checkoutUrl": checkoutUrl, "createdAt": createdAt!.toIso8601String(), "id": id, "note": note, "totalQuantity": totalQuantity, "updatedAt": updatedAt!.toIso8601String()};
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
