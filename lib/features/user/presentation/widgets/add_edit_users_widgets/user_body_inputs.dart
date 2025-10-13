import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weider/core/dependency_injection/di.dart';
import 'package:weider/features/user/data/models/user_model/user_model.dart';
import 'package:weider/features/user/presentation/controllers/uesr_image/user_image_cubit.dart';

import 'image_part/custom_image_selection.dart';
import 'details_list.dart';

class UserBodyInputs extends StatelessWidget {
  const UserBodyInputs({super.key, this.userModel});
    final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserImageCubit>(
          create: (context) => getIt<UserImageCubit>(),
        child : UserBodyInputsPrepared(userModel: userModel,),
    );
  }
}

class UserBodyInputsPrepared extends StatefulWidget {
  const UserBodyInputsPrepared({super.key, this.userModel});
  final UserModel? userModel;
  @override
  State<UserBodyInputsPrepared> createState() => _UserBodyInputsPreparedState();
}

class _UserBodyInputsPreparedState extends State<UserBodyInputsPrepared> {
  @override
  void initState() {
    super.initState();
    if (widget.userModel != null) {
      context.read<UserImageCubit>().storeImagePath(
        imagePath: widget.userModel!.imagePath,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 16),
        child: Column(
          spacing: 16,

          children: [
            BlocBuilder<UserImageCubit, String?>(
              builder: (context, state) {
                return CustomImageSelection(imagePath: state);
              },
            ),
            DetailsList(userModel: widget.userModel),
          ],
        ),
      ),
    );
  }
}
