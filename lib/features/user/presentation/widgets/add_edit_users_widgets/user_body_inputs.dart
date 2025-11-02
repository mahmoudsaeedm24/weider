import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weider/features/user/data/models/user_model/user_model.dart';
import 'package:weider/features/user/presentation/controllers/uesr_image/user_image_cubit.dart';

import 'details_list.dart';
import 'image_part/custom_image_selection.dart';

class UserBodyInputs extends StatelessWidget {
  const UserBodyInputs({super.key, this.userModel, required this.formState, required this.nameController, required this.startController, required this.phoneController, required this.intervalController, required this.priceController, required this.noteController});
    final UserModel? userModel;
 final  GlobalKey<FormState> formState;
  final TextEditingController nameController,
      startController,
      phoneController,
      intervalController,
      priceController,
      noteController;
  @override
  Widget build(BuildContext context) {
    return UserBodyInputsPrepared(
      userModel: userModel, 
      formState: formState, 
      nameController: nameController, 
      startController: startController, 
      phoneController: phoneController, 
      intervalController: intervalController, 
      priceController: priceController, 
      noteController: noteController,
      );
  }
}

class UserBodyInputsPrepared extends StatefulWidget {
   final  GlobalKey<FormState> formState;
  final TextEditingController nameController,
      startController,
      phoneController,
      intervalController,
      priceController,
      noteController;
  const UserBodyInputsPrepared({super.key, this.userModel, required this.formState, required this.nameController, required this.startController, required this.phoneController, required this.intervalController, required this.priceController, required this.noteController});
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
            DetailsList(userModel: widget.userModel, 
            formState: widget.formState, nameController: widget.nameController, startController: widget.startController, phoneController: widget.phoneController, intervalController: widget.intervalController, priceController: widget.priceController, noteController: widget.noteController,),
          ],
        ),
      ),
    );
  }
}
