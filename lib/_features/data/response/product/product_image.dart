import 'package:hollypalm/_features/data/response/product/product_featured_image.dart';

class Images {
  List<ImagesEdge>? edges;

  Images({this.edges});

  factory Images.fromJson(Map<String, dynamic> json) => Images(edges: List<ImagesEdge>.from(json["edges"].map((x) => ImagesEdge.fromJson(x))));

  Map<String, dynamic> toJson() => {"edges": List<dynamic>.from(edges!.map((x) => x.toJson()))};
}

class ImagesEdge {
  FeaturedImage? node;

  ImagesEdge({this.node});

  factory ImagesEdge.fromJson(Map<String, dynamic> json) => ImagesEdge(node: FeaturedImage.fromJson(json["node"]));

  Map<String, dynamic> toJson() => {"node": node?.toJson()};
}
