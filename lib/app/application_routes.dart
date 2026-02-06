import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hollypalm/core/utils/keys.dart';
import 'package:hollypalm/features/presentation/view/home/home_view.dart';

class ApplicationRoutes {
  static String initialRoute = '/';
  static String dashboardPage = 'dashboard';

  static GoRouter routes = GoRouter(
    initialLocation: ApplicationRoutes.initialRoute,
    navigatorKey: rootNavigatorKey,
    routes: <GoRoute>[
      GoRoute(
        path: "/",
        name: 'login',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView();
        },
      ),
    ],
  );
}
