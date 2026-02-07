// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hollypalm/_core/base/app_config.dart';

final getIt = GetIt.instance;

class ShopifyGraphQLService {
  ShopifyGraphQLService();

  Future<Map<String, dynamic>> query({required String query, Map<String, dynamic>? variables}) async {
    try {
      final response = await createDio().post('', data: {'query': query, 'variables': variables ?? {}});

      if (response.data['errors'] != null) {
        throw Exception(response.data['errors'][0]['message']);
      }

      return response.data['data'];
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }

  Future<Map<String, dynamic>> mutation({required String mutation, Map<String, dynamic>? variables}) async {
    return query(query: mutation, variables: variables);
  }
}

Dio createDio() {
  final dio = Dio(BaseOptions(baseUrl: AppConfig.apiConnectionHost, headers: AppConfig().apiHeaders, sendTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 10)));

  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  return dio;
}
