import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weider/core/dependency_injection/di.dart';
import 'package:weider/core/extension/text_style_on_context.dart';
import 'package:weider/core/theme/app_colors.dart';
import 'package:weider/features/user/data/models/user_model/user_model.dart';
import 'package:weider/features/user/presentation/controllers/get_all_users/get_all_users_cubit.dart';
import 'package:weider/features/user/presentation/controllers/remove_user/remove_user_cubit.dart';
import 'package:weider/features/user/presentation/widgets/display_users_widgets/UserCard/user_card.dart';

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
    return BlocProvider(
      create: (context) => getIt<RemoveUserCubit>(),
      child: Builder(
        builder: (context) => Dismissible(
          key: ValueKey(users[index]),
          dismissThresholds: {DismissDirection.startToEnd: 0.3},
          onUpdate: (details) {
            if (details.progress == .33) {}
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment(.8, 0),
            child: Icon(Icons.delete),
          ),
          direction: DismissDirection.startToEnd,

          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: AppColors.primary,
                title: Text(
                  "هل تود حذف ${users[index].name} ؟",
                  style: context.semiB18.copyWith(color: AppColors.onPrimary),
                ),
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
          onDismissed: (direction) async {
            await context.read<RemoveUserCubit>().removeUser(
              user: users[index],
            );
            if (context.mounted) {
              context.read<GetUsersCubit>().getUsers();
            }
          },
          behavior: HitTestBehavior.opaque,

          child: UserCard(userModel: users[index]),
        ),
      ),
    );
  }
}
