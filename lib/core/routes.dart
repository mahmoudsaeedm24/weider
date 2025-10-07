import 'package:flutter/material.dart';
import 'package:weider/features/user/presentation/view/add_edit_user_screen.dart';
import 'package:weider/features/user/presentation/view/display_users_screen.dart';

class Screens {
  Screens._();

  static const String home = 'home';
  static const String addEditUser = 'addEditNewUser';
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {

  switch (settings.name) {
    case Screens.home: // أو Screens.home.name
      return MaterialPageRoute(
        builder: (context) =>
            const DisplayUsersScreen(),
      );

    case Screens.addEditUser: // أو Screens.addNewUser.name
      return MaterialPageRoute(
        builder: (context) => AddEditUserScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) =>
            const Scaffold(body: Center(child: Text("Page not found"))),
      );
  }
}
