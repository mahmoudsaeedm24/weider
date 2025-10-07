import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weider/core/dependency_injection/di.dart';
import 'package:weider/core/routes.dart';
import 'package:weider/core/theme/app_theme.dart';
import 'package:weider/core/utils/hive_prepared.dart';
import 'package:weider/features/user/presentation/view/display_users_screen.dart';

import 'features/user/presentation/controllers/get_all_users/get_all_users_cubit.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HivePrepared.init();
  initDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LightTheme().themeData,
      darkTheme: DarkTheme().themeData,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      navigatorObservers: [routeObserver], // عرفته تحت

      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl, // أو TextDirection.ltr
          child: child!,
        );
      },
      home: BlocProvider(
        create: (context) => getIt<GetUsersCubit>(),
        child: DisplayUsersScreen(),
      ),
    );
  }
}
