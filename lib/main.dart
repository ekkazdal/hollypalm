import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollypalm/app/application_routes.dart';
import 'package:hollypalm/app/service_locator.dart';
import 'package:hollypalm/_core/utils/theme/screen_sizes.dart';

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await serviceLocator();
  HttpOverrides.global = CustomHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.light, systemNavigationBarColor: Colors.white));
}

Future<void> main() async {
  try {
    await _init();
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('tr'), Locale('ar'), Locale('az'), Locale('de'), Locale('en'), Locale('es'), Locale('fa'), Locale('fr'), Locale('it'), Locale('nl'), Locale('pt'), Locale('ru')],
        path: 'assets/translations',
        startLocale: const Locale('tr'),
        fallbackLocale: const Locale('tr'),
        saveLocale: true,
        child: ProviderScope(child: HollyPalmApp()),
      ),
    );
  } catch (e, stackTrace) {
    // Hata durumunda detaylı log
    log('❌ UYGULAMA BAŞLATMA HATASI: $e');
    log('📍 Stack Trace: $stackTrace');
    rethrow;
  }
}

class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class HollyPalmApp extends StatelessWidget {
  const HollyPalmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: ApplicationRoutes.routes,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
      ),
      themeMode: ThemeMode.system,
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        ScreenSize.getSizes(mediaQuery.size.width, mediaQuery.size.height);
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
