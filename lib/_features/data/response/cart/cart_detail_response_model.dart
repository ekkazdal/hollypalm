// To parse this JSON data, do
//
//     final cartDetailResponseModel = cartDetailResponseModelFromJson(jsonString);

import 'dart:convert';

CartDetailResponseModel cartDetailResponseModelFromJson(String str) => CartDetailResponseModel.fromJson(json.decode(str));

String cartDetailResponseModelToJson(CartDetailResponseModel data) => json.encode(data.toJson());

class CartDetailResponseModel {
  CartLinesAdd? cartLinesAdd;

  CartDetailResponseModel({this.cartLinesAdd});

  factory CartDetailResponseModel.fromJson(Map<String, dynamic> json) => CartDetailResponseModel(cartLinesAdd: CartLinesAdd.fromJson(json["cartLinesAdd"]));

  Map<String, dynamic> toJson() => {"cartLinesAdd": cartLinesAdd!.toJson()};
}

class CartLinesAdd {
  Cart? cart;
  List<UserError>? userErrors;
  List<dynamic>? warnings;

  CartLinesAdd({this.cart, this.userErrors, this.warnings});

  factory CartLinesAdd.fromJson(Map<String, dynamic> json) => CartLinesAdd(cart: Cart.fromJson(json["cart"]), userErrors: List<UserError>.from(json["userErrors"].map((x) => UserError.fromJson(x))), warnings: List<dynamic>.from(json["warnings"].map((x) => x)));

  Map<String, dynamic> toJson() => {"cart": cart?.toJson(), "userErrors": List<dynamic>.from(userErrors!.map((x) => x.toJson())), "warnings": List<dynamic>.from(warnings!.map((x) => x))};
}

class Cart {
  String? id;
  int? totalQuantity;
  Lines? lines;

  Cart({this.id, this.totalQuantity, this.lines});

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(id: json["id"], totalQuantity: json["totalQuantity"], lines: Lines.fromJson(json["lines"]));

  Map<String, dynamic> toJson() => {"id": id, "totalQuantity": totalQuantity, "lines": lines?.toJson()};
}

class Lines {
  List<Edge>? edges;

  Lines({this.edges});

  factory Lines.fromJson(Map<String, dynamic> json) => Lines(edges: List<Edge>.from(json["edges"].map((x) => Edge.fromJson(x))));

  Map<String, dynamic> toJson() => {"edges": List<dynamic>.from(edges!.map((x) => x.toJson()))};
}

class Edge {
  CartDetailNode? node;

  Edge({this.node});

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(node: CartDetailNode.fromJson(json["node"]));

  Map<String, dynamic> toJson() => {"node": node?.toJson()};
}

class CartDetailNode {
  String? id;
  int? quantity;
  Merchandise? merchandise;

  CartDetailNode({this.id, this.quantity, this.merchandise});

  factory CartDetailNode.fromJson(Map<String, dynamic> json) => CartDetailNode(id: json["id"], quantity: json["quantity"], merchandise: Merchandise.fromJson(json["merchandise"]));

  Map<String, dynamic> toJson() => {"id": id, "quantity": quantity, "merchandise": merchandise!.toJson()};
}

class Merchandise {
  String? id;
  String? title;
  String? sku;
  Price? price;

  Merchandise({this.id, this.title, this.sku, this.price});

  factory Merchandise.fromJson(Map<String, dynamic> json) => Merchandise(id: json["id"], title: json["title"], sku: json["sku"], price: Price.fromJson(json["price"]));

  Map<String, dynamic> toJson() => {"id": id, "title": title, "sku": sku, "price": price!.toJson()};
}

class Price {
  String? amount;
  String? currencyCode;

  Price({this.amount, this.currencyCode});

  factory Price.fromJson(Map<String, dynamic> json) => Price(amount: json["amount"], currencyCode: json["currencyCode"]);

  Map<String, dynamic> toJson() => {"amount": amount, "currencyCode": currencyCode};
}

class UserError {
  List<String>? field;
  String? message;
  String? code;

  UserError({this.field, this.message, this.code});

  factory UserError.fromJson(Map<String, dynamic> json) => UserError(field: List<String>.from(json["field"].map((x) => x)), message: json["message"], code: json["code"]);

  Map<String, dynamic> toJson() => {"field": List<dynamic>.from(field!.map((x) => x)), "message": message, "code": code};
}

class Extensions {
  Cost? cost;

  Extensions({this.cost});

  factory Extensions.fromJson(Map<String, dynamic> json) => Extensions(cost: Cost.fromJson(json["cost"]));

  Map<String, dynamic> toJson() => {"cost": cost!.toJson()};
}

class Cost {
  int? requestedQueryCost;

  Cost({this.requestedQueryCost});

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(requestedQueryCost: json["requestedQueryCost"]);

  Map<String, dynamic> toJson() => {"requestedQueryCost": requestedQueryCost};
}
