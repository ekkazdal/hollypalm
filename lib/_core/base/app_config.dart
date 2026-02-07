// ignore_for_file: unreachable_switch_default

import 'package:hollypalm/_features/data/enums/app_type.dart';

class AppConfig {
  static APPType appType = APPType.Stage;

  static String languageCode = "";

  static String get apiConnectionHost {
    switch (appType) {
      case APPType.Prod:
        return "https://hollypalm-test.myshopify.com/api/2026-01/graphql.json/";
      case APPType.Stage:
        return "https://hollypalm-test.myshopify.com/api/2026-01/graphql.json/";
      default:
        return "https://hollypalm-test.myshopify.com/api/2026-01/graphql.json/";
    }
  }

  Map<String, String> get apiHeaders {
    switch (appType) {
      case APPType.Prod:
        return defaultAppHeaders;
      case APPType.Stage:
        return defaultAppHeaders;
      default:
        return defaultAppHeaders;
    }
  }

  final Map<String, String> defaultAppHeaders = <String, String>{'Content-Type': 'application/json', 'X-Shopify-Storefront-Access-Token': "00e75e3bfd60f9cbb0d4f357c372d2b0"};
}
