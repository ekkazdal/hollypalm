import 'package:hollypalm/_features/data/response/product/product_featured_image.dart';

class Variants {
  List<VariantsEdge>? edges;

  Variants({this.edges});

  factory Variants.fromJson(Map<String, dynamic> json) => Variants(edges: List<VariantsEdge>.from(json["edges"].map((x) => VariantsEdge.fromJson(x))));
}

class VariantsEdge {
  FluffyNode? node;

  VariantsEdge({this.node});

  factory VariantsEdge.fromJson(Map<String, dynamic> json) => VariantsEdge(node: FluffyNode.fromJson(json["node"]));
}

class FluffyNode {
  String? id;
  String? barcode;
  FeaturedImage? image;
  Price? price;
  Product? product;

  FluffyNode({this.id, this.barcode, this.image, this.price, this.product});

  factory FluffyNode.fromJson(Map<String, dynamic> json) => FluffyNode(id: json["id"], barcode: json["barcode"], image: json["image"] != null ? FeaturedImage.fromJson(json["image"]) : json["image"], price: Price.fromJson(json["price"]), product: Product.fromJson(json["product"]));
}

class Product {
  bool? availableForSale;
  DateTime? createdAt;
  String? description;
  String? descriptionHtml;
  String? encodedVariantAvailability;
  String? encodedVariantExistence;
  String? handle;
  String? id;
  bool? isGiftCard;
  String? onlineStoreUrl;
  String? productType;
  DateTime? publishedAt;
  bool? requiresSellingPlan;
  String? title;
  int? totalInventory;
  String? trackingParameters;
  DateTime? updatedAt;
  String? vendor;

  Product({
    this.availableForSale,
    this.createdAt,
    this.description,
    this.descriptionHtml,
    this.encodedVariantAvailability,
    this.encodedVariantExistence,
    this.handle,
    this.id,
    this.isGiftCard,
    this.onlineStoreUrl,
    this.productType,
    this.publishedAt,
    this.requiresSellingPlan,
    this.title,
    this.totalInventory,
    this.trackingParameters,
    this.updatedAt,
    this.vendor,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    availableForSale: json["availableForSale"],
    createdAt: DateTime.parse(json["createdAt"]),
    description: json["description"],
    descriptionHtml: json["descriptionHtml"],
    encodedVariantAvailability: json["encodedVariantAvailability"],
    encodedVariantExistence: json["encodedVariantExistence"],
    handle: json["handle"],
    id: json["id"],
    isGiftCard: json["isGiftCard"],
    onlineStoreUrl: json["onlineStoreUrl"],
    productType: json["productType"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    requiresSellingPlan: json["requiresSellingPlan"],
    title: json["title"],
    totalInventory: json["totalInventory"],
    trackingParameters: json["trackingParameters"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    vendor: json["vendor"],
  );
}

class Price {
  String? amount;
  String? currencyCode;

  Price({this.amount, this.currencyCode});

  factory Price.fromJson(Map<String, dynamic> json) => Price(amount: json["amount"], currencyCode: json["currencyCode"]);

  Map<String, dynamic> toJson() => {"amount": amount, "currencyCode": currencyCode};
}
