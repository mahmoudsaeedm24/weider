import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weider/core/theme/app_colors.dart';
import 'package:weider/features/user/data/models/user_model.dart';
import 'package:weider/features/user/presentation/controllers/get_all_users/get_all_users_cubit.dart';
import 'package:weider/features/user/presentation/controllers/remove_user/remove_user_cubit.dart';
import 'package:weider/features/user/presentation/widgets/display_users_widgets/user_card.dart';

class DismissibleUserCard extends StatelessWidget {
  const DismissibleUserCard({
    super.key,
    required this.users,
    required this.index,
  });
  final List<UserModel> users;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(users[index].id),
      dismissThresholds: {DismissDirection.startToEnd: 0.3},
      onUpdate: (details) {
        if (details.progress == .33) {}
      },
      background: Container(
        color: Colors.red,
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.backgroundLight),
            fixedSize: WidgetStatePropertyAll(Size(60, 50)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              ),
            ),
          ),
          child: Text("حذف"),
        ),
      ),
      direction: DismissDirection.startToEnd,

      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            // backgroundColor: C,
            title: Text("هل تود حذف ${users[index].name} ؟"),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.error),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text("احذف"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text("الغاء الحذف"),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        context.read<RemoveUserCubit>().removeUser(user: users[index]);
        context.read<GetUsersCubit>().getUsers();
      },

      child: UserCard(userModel: users[index]),
    );
  }
}
