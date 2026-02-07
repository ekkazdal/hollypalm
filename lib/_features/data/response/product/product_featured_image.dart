class FeaturedImage {
  String? altText;
  int? height;
  String? id;
  String? originalSrc;
  String? src;
  String? thumbhash;
  String? transformedSrc;
  String? url;
  int? width;

  FeaturedImage({this.altText, this.height, this.id, this.originalSrc, this.src, this.thumbhash, this.transformedSrc, this.url, this.width});

  factory FeaturedImage.fromJson(Map<String, dynamic> json) =>
      FeaturedImage(altText: json["altText"], height: json["height"], id: json["id"], originalSrc: json["originalSrc"], src: json["src"], thumbhash: json["thumbhash"], transformedSrc: json["transformedSrc"], url: json["url"], width: json["width"]);

  Map<String, dynamic> toJson() => {"altText": altText, "height": height, "id": id, "originalSrc": originalSrc, "src": src, "thumbhash": thumbhash, "transformedSrc": transformedSrc, "url": url, "width": width};
}
