import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weider/core/dependency_injection/di.dart';
import 'package:weider/features/user/presentation/view/add_edit_user_screen.dart';
import 'package:weider/features/user/presentation/view/display_users_screen.dart';

import '../features/user/presentation/controllers/get_all_users/get_all_users_cubit.dart';

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
            BlocProvider(
        create: (context) => getIt<GetUsersCubit>(),
        child: const DisplayUsersScreen(),
      ),
      );

    case Screens.addEditUser: // أو Screens.addNewUser.name
      return MaterialPageRoute(
        builder: (context) => const AddEditUserScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) =>
            const Scaffold(body: Center(child: Text("Page not found"))),
      );
  }
}
