import 'package:flutter/material.dart';

import '../widgets/display_users_widgets/display_users_body.dart';

class DisplayUsersScreen extends StatelessWidget {
  const DisplayUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
      ),
      body: DisplayUsersBody(),
    );
  }
}
