// ignore_for_file: constant_identifier_names, unreachable_switch_default

enum RequestType { get, post, put, delete }

extension RequestTypeExtension on RequestType {
  String typeName() {
    switch (this) {
      case RequestType.get:
        return "GET";
      case RequestType.post:
        return "POST";
      case RequestType.put:
        return "PUT";
      case RequestType.delete:
        return "DELETE";
      default:
        return "GET";
    }
  }
}
