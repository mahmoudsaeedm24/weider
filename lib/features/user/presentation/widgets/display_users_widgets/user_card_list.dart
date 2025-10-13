import 'package:flutter/material.dart';

import '../../../data/models/user_model/user_model.dart';
import 'dismissible_user_card.dart';

class UserCardList extends StatelessWidget {
  const UserCardList({super.key, required this.users});

  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: users.length,
      itemBuilder: (context, index) =>
          DismissibleUserCard(users: users, index: index),
    );
  }
}
