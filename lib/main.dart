import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:weider/core/dependency_injection/di.dart';
import 'package:weider/core/routes.dart';
import 'package:weider/core/services/notification_prepared.dart';
import 'package:weider/core/theme/app_theme.dart';
import 'package:weider/core/utils/hive_prepared.dart';
import 'package:timezone/data/latest.dart' as tz;


final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HivePrepared.init();
  NotificationPrepared.askPermissions();
  NotificationPrepared.init();

  tz.initializeTimeZones();

  initDI();
  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => MyApp(), // Wrap your app
    // ),
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // log("Shortest side = ${context.mySize.shortestSide}");
    // log("aspectRatio = ${context.mySize.aspectRatio}");
    // log("sp = ${context.sp}");
    // log("maxHeight = ${context.maxHeight}");
    // log("maxWidth = ${context.maxWidth}");
    return MaterialApp(
      theme: LightTheme(context: context).themeData,
      darkTheme: DarkTheme(context: context).themeData,
      locale: DevicePreview.locale(context),
      themeMode: ThemeMode.light,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      navigatorObservers: [routeObserver], // عرفته تحت
      initialRoute: Screens.home,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl, // أو TextDirection.ltr
          child: child!,
          // child: DevicePreview.appBuilder(context, child),
        );
      },
    );
  }
}
