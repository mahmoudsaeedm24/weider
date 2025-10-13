import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weider/core/dependency_injection/di.dart';
import 'package:weider/core/extension/text_style_on_context.dart';
import 'package:weider/features/user/presentation/widgets/add_edit_users_widgets/user_body_inputs.dart';
import 'package:weider/features/user/data/models/user_model/user_model.dart';
import 'package:weider/features/user/presentation/controllers/add_new_user/add_new_user_cubit.dart';

import '../../../../core/theme/app_colors.dart';
import '../controllers/uesr_image/user_image_cubit.dart';

///* userModel is a model that i will modify it
class AddEditUserScreen extends StatelessWidget {
  const AddEditUserScreen({super.key, this.userModel});
  final UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AddEditUserCubit>()),
        BlocProvider<UserImageCubit>(
          create: (context) => getIt<UserImageCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                userModel != null ? "تعديل البيانات" : "إضافة عضو",
                style: context.semiB16.copyWith(color: AppColors.onPrimary),
              ),
            ),
            body: UserBodyInputs(userModel: userModel),
          );
        },
      ),
    );
  }
}
