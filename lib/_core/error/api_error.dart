// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:dio/dio.dart';

const String _unknownError = 'İsteğinizi şu anda gerçekleştiremiyoruz. Lütfen daha sonra tekrar deneyin.';

class ApiError implements Exception {
  final dynamic _error;
  final String? path;

  ApiError(this._error, [this.path]);

  int get statusCode {
    if (_error is DioException) {
      return _error.response?.statusCode ?? -1;
    }
    return -1;
  }

  int get errorCode {
    if (_error is HandshakeException || _error is SocketException) {
      return statusCode;
    } else {
      if (_error is DioException) {
        final response = (_error).response;
        if (response == null || response.data == null) {
          return statusCode;
        } else {
          final data = response.data;
          if (data is Map) {
            if (data.containsKey('error_code')) return data['error_code'];
            return statusCode;
          }
          return statusCode;
        }
      }
    }
    return -1;
  }

  List<String> get messages {
    if (_error is DioException) {
      if (_error.error is HandshakeException || _error.error is SocketException) {
        return ['İnternet bağlantınızı kontrol ediniz.'];
      }

      final response = (_error).response;
      if (response == null) {
        return [_unknownError];
      }

      final data = response.data;
      if (data is Map<String, dynamic>) {
        // final errorModel = ErrorResponseModel.fromJson(data);
        List<String> allMessages = [];

        // if (errorModel.errorMessage != null && errorModel.errorMessage!.isNotEmpty) {
        //   allMessages.add(errorModel.errorMessage!);
        // }

        // allMessages.addAll(errorModel.dataMessages);

        return allMessages.isNotEmpty ? allMessages : [_unknownError];
      }
    }
    return [_unknownError];
  }

  String get message => messages.first;

  String get messageErrorCode {
    if (_error is DioException) {
      final response = (_error).response;

      final data = response?.data;
      if (data is Map<String, dynamic>) {
        //    final errorModel = ErrorResponseModel.fromJson(data);

        // Eğer API tarafında errorCode yoksa "0" dön
        return '';
      }
    }
    return '0';
  }

  @override
  String toString() => '$_error';
}
