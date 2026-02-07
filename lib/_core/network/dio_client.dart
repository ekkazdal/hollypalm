// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, depend_on_referenced_packages, unreachable_switch_default

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hollypalm/_core/base/app_config.dart';
import 'package:hollypalm/_core/error/api_error.dart';
import 'package:hollypalm/_core/utils/model_mapper.dart';
import 'package:hollypalm/_features/data/enums/request_type.dart';

final getIt = GetIt.instance;

class DioClient {
  late Dio dioClient;
  late Options requestOptions;

  DioClient() {
    dioClient = Dio(BaseOptions(baseUrl: AppConfig.apiConnectionHost, connectTimeout: const Duration(seconds: 10), sendTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 10)));

    // Sentry Dio interceptor'ını ekle

    requestOptions = Options(headers: AppConfig().defaultAppHeaders);
  }

  Future<T> handleRequest<T extends Object?>({required final String path, required final RequestType type, required final Map<String, dynamic> headers, bool? showError, final Map<String, dynamic>? body, final Map<String, dynamic>? params, final void Function(CancelToken)? onToken}) async {
    dioClient.options.baseUrl = AppConfig.apiConnectionHost;
    final cancelToken = CancelToken();
    final options = requestOptions.copyWith(headers: headers, method: type.typeName());
    log('${AppConfig.apiConnectionHost}$path');
    onToken?.call(cancelToken);
    final Future<Response> callback;
    switch (type) {
      case RequestType.get:
        callback = dioClient.get(path, options: options, cancelToken: cancelToken);
        break;
      case RequestType.post:
        callback = dioClient.post(path, options: options, data: body, cancelToken: cancelToken);

        break;
      case RequestType.put:
        callback = dioClient.put(path, options: options, data: json.encode(body), cancelToken: cancelToken);
        break;
      case RequestType.delete:
        callback = dioClient.delete(path, options: options, data: json.encode(body), cancelToken: cancelToken);
        break;
      default:
        throw Exception('Unsupported request type!');
    }
    try {
      log(json.encode(body).toString());
      final response = await callback;
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        log(response.data);
        if (response.data is Map) {
          return modelMapper<T>(response.data) ?? response.data;
        } else {
          return response.data;
        }
      }

      if (showError == true) {
        throw ApiError(response);
      } else {
        throw ApiError('empty');
      }
    } catch (error) {
      if (showError == true) {
        throw ApiError(error, path);
      } else {
        throw Exception();
      }
    }
  }
}

Dio createShopifyDio() {
  return Dio(BaseOptions(baseUrl: 'https://hollypalm-test.myshopify.com/api/2026-01/graphql.json', headers: {'Content-Type': 'application/json', 'X-Shopify-Storefront-Access-Token': 'STOREFRONT_ACCESS_TOKEN_BURAYA'}))..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
}
