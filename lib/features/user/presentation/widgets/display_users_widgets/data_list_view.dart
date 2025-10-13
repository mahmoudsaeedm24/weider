import 'package:flutter/material.dart';
import 'package:weider/core/extension/text_style_on_context.dart';
import 'package:weider/core/theme/app_colors.dart';

import '../../../data/models/users_state/user_state_model.dart';
import 'user_card_list.dart';

class DataListView extends StatefulWidget {
  const DataListView({super.key, required this.users});
  final UserStateModel users;

  @override
  State<DataListView> createState() => _DataListViewState();
}

class _DataListViewState extends State<DataListView> {
  bool _isShowDeactiveUsers = false;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        UserCardList(users: widget.users.active),
        SliverToBoxAdapter(
          child: TextButton.icon(
            onPressed: () {
              setState(() {
                _isShowDeactiveUsers = !_isShowDeactiveUsers;
              });
            },
            label: Text(
              "-----------------------------------",
              style: context.med12.copyWith(color: AppColors.accentLight),
            ),
            icon: _isShowDeactiveUsers
                ? Icon(Icons.arrow_drop_down)
                : Icon(Icons.arrow_right_outlined),
          ),
        ),

        _isShowDeactiveUsers
            ? UserCardList(users: widget.users.deactive)
            : SliverToBoxAdapter(child: Container()),
      ],
    );
  }
}
