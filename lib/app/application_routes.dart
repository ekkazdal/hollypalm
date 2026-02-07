import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hollypalm/_core/utils/keys.dart';
import 'package:hollypalm/_features/presentation/home/view/home_view.dart';
import 'package:hollypalm/_features/presentation/product_detail/view/product_detail.dart';

class ApplicationRoutes {
  static String initialRoute = '/';
  static String dashboardPage = 'dashboard';

  static GoRouter routes = GoRouter(
    initialLocation: ApplicationRoutes.initialRoute,
    navigatorKey: rootNavigatorKey,
    routes: <GoRoute>[
      GoRoute(
        path: "/",
        name: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView();
        },
      ),
      GoRoute(
        path: '/product-detail',
        builder: (context, state) {
          return ProductDetail(productId: state.extra as String);
        },
      ),
    ],
  );
}
