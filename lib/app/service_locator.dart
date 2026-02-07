import 'package:get_it/get_it.dart';
import 'package:hollypalm/_core/network/dio_client.dart';
import 'package:hollypalm/_core/services/shared/app_service.dart';
import 'package:hollypalm/_core/services/shopify_graphql_service.dart';
import 'package:hollypalm/_core/services/shopify_services.dart';

final getIt = GetIt.instance;

Future<void> serviceLocator() async {
  getIt.registerSingleton<DioClient>(DioClient());
  getIt.registerSingleton<ShopifyGraphQLService>(ShopifyGraphQLService());
  getIt.registerSingleton<ShopifyServices>(ShopifyServices());
  getIt.registerSingleton<AppService>(AppService());
}
