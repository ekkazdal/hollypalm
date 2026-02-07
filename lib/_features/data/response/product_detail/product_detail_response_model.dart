// To parse this JSON data, do
//
//     final productDetailResponseModel = productDetailResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:hollypalm/_features/data/response/product/product_image.dart';

ProductDetailResponseModel productDetailResponseModelFromJson(String str) => ProductDetailResponseModel.fromJson(json.decode(str));

String productDetailResponseModelToJson(ProductDetailResponseModel data) => json.encode(data.toJson());

class ProductDetailResponseModel {
  Product? product;

  ProductDetailResponseModel({this.product});

  factory ProductDetailResponseModel.fromJson(Map<String, dynamic> json) => ProductDetailResponseModel(product: Product.fromJson(json["product"]));

  Map<String, dynamic> toJson() => {"product": product!.toJson()};
}

class Product {
  bool? availableForSale;
  DateTime? createdAt;
  String? description;
  String? descriptionHtml;
  String? id;
  String? productType;
  DateTime? publishedAt;
  bool? requiresSellingPlan;
  String? title;
  int? totalInventory;
  String? vendor;
  Variants? variants;
  Images? images;

  Product({this.availableForSale, this.createdAt, this.description, this.descriptionHtml, this.id, this.productType, this.publishedAt, this.requiresSellingPlan, this.title, this.totalInventory, this.vendor, this.variants, this.images});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    availableForSale: json["availableForSale"],
    createdAt: DateTime.parse(json["createdAt"]),
    description: json["description"],
    descriptionHtml: json["descriptionHtml"],
    id: json["id"],
    productType: json["productType"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    requiresSellingPlan: json["requiresSellingPlan"],
    title: json["title"],
    totalInventory: json["totalInventory"],
    vendor: json["vendor"],
    variants: Variants.fromJson(json["variants"]),
    images: Images.fromJson(json["images"]),
  );

  Map<String, dynamic> toJson() => {
    "availableForSale": availableForSale,
    "createdAt": createdAt!.toIso8601String(),
    "description": description,
    "descriptionHtml": descriptionHtml,
    "id": id,
    "productType": productType,
    "publishedAt": publishedAt!.toIso8601String(),
    "requiresSellingPlan": requiresSellingPlan,
    "title": title,
    "totalInventory": totalInventory,
    "vendor": vendor,
    "variants": variants!.toJson(),
    "images": images!.toJson(),
  };
}

class Variants {
  List<Edge>? edges;

  Variants({this.edges});

  factory Variants.fromJson(Map<String, dynamic> json) => Variants(edges: List<Edge>.from(json["edges"].map((x) => Edge.fromJson(x))));

  Map<String, dynamic> toJson() => {"edges": List<dynamic>.from(edges!.map((x) => x.toJson()))};
}

class Edge {
  Node? node;

  Edge({this.node});

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(node: Node.fromJson(json["node"]));

  Map<String, dynamic> toJson() => {"node": node!.toJson()};
}

class Node {
  bool? availableForSale;
  bool? currentlyNotInStock;
  String? id;
  int? quantityAvailable;
  String? title;
  double? weight;
  String? weightUnit;
  Price? price;
  Image? image;

  Node({this.availableForSale, this.currentlyNotInStock, this.id, this.quantityAvailable, this.title, this.weight, this.weightUnit, this.price, this.image});

  factory Node.fromJson(Map<String, dynamic> json) => Node(
    availableForSale: json["availableForSale"],
    currentlyNotInStock: json["currentlyNotInStock"],
    id: json["id"],
    quantityAvailable: json["quantityAvailable"],
    title: json["title"],
    weight: json["weight"],
    weightUnit: json["weightUnit"],
    price: Price.fromJson(json["price"]),
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {"availableForSale": availableForSale, "currentlyNotInStock": currentlyNotInStock, "id": id, "quantityAvailable": quantityAvailable, "title": title, "weight": weight, "weightUnit": weightUnit, "price": price!.toJson(), "image": image!.toJson()};
}

class Price {
  String? amount;
  String? currencyCode;

  Price({this.amount, this.currencyCode});

  factory Price.fromJson(Map<String, dynamic> json) => Price(amount: json["amount"], currencyCode: json["currencyCode"]);

  Map<String, dynamic> toJson() => {"amount": amount, "currencyCode": currencyCode};
}

class Image {
  String? altText;
  int? height;
  String? id;
  String? originalSrc;
  String? src;
  String? thumbhash;
  String? transformedSrc;
  String? url;
  int? width;

  Image({this.altText, this.height, this.id, this.originalSrc, this.src, this.thumbhash, this.transformedSrc, this.url, this.width});

  factory Image.fromJson(Map<String, dynamic> json) => Image(altText: json["altText"], height: json["height"], id: json["id"], originalSrc: json["originalSrc"], src: json["src"], thumbhash: json["thumbhash"], transformedSrc: json["transformedSrc"], url: json["url"], width: json["width"]);

  Map<String, dynamic> toJson() => {"altText": altText, "height": height, "id": id, "originalSrc": originalSrc, "src": src, "thumbhash": thumbhash, "transformedSrc": transformedSrc, "url": url, "width": width};
}
