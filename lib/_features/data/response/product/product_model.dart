// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:hollypalm/_features/data/response/product/product_featured_image.dart';
import 'package:hollypalm/_features/data/response/product/product_image.dart';
import 'package:hollypalm/_features/data/response/product/product_price.dart';
import 'package:hollypalm/_features/data/response/product/product_varyant_response.dart';

class Products {
  List<Edge>? edges;

  Products({this.edges});

  factory Products.fromJson(Map<String, dynamic> json) => Products(edges: List<Edge>.from(json["edges"].map((x) => Edge.fromJson(x))));
}

class Edge {
  Node? node;

  Edge({this.node});

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(node: Node.fromJson(json["node"]));
}

class Node {
  String? id;
  String? title;
  String? vendor;
  String? description;
  String? descriptionHtml;
  PriceRange? priceRange;
  FeaturedImage? featuredImage;
  Images? images;
  Variants? variants;

  Node({this.id, this.title, this.vendor, this.description, this.descriptionHtml, this.priceRange, this.featuredImage, this.images, this.variants});

  factory Node.fromJson(Map<String, dynamic> json) => Node(
    id: json["id"],
    title: json["title"],
    vendor: json["vendor"],
    description: json["description"],
    descriptionHtml: json["descriptionHtml"],
    priceRange: PriceRange.fromJson(json["priceRange"]),
    featuredImage: json["featuredImage"] != null ? FeaturedImage.fromJson(json["featuredImage"]) : json["featuredImage"],
    images: Images.fromJson(json["images"]),
    variants: Variants.fromJson(json["variants"]),
  );
}
