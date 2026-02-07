class ErrorResponseModel {
  String? message;
  bool? isSuccess;
  Data? data;

  ErrorResponseModel({this.message, this.isSuccess, this.data});

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) => ErrorResponseModel(message: json['message'] as String?, isSuccess: json['isSuccess'] as bool?, data: (json['data'] != null) ? Data.fromJson(json['data']) : null);

  String? get errorMessage => data?.errorMessage;
  List<String> get dataMessages => data?.errorDetails ?? [];
}

class Data {
  String? errorMessage;
  List<String>? errorDetails;

  Data({this.errorMessage, this.errorDetails});

  factory Data.fromJson(Map<String, dynamic> json) => Data(errorMessage: json['errorMessage'] as String?, errorDetails: (json['errorDetails'] as List<dynamic>?)?.map((e) => e as String).toList());
}
