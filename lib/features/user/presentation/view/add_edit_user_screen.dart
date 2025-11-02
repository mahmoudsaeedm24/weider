import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weider/core/dependency_injection/di.dart';
import 'package:weider/core/extension/text_style_on_context.dart';
import 'package:weider/features/user/presentation/widgets/add_edit_users_widgets/user_body_inputs.dart';
import 'package:weider/features/user/data/models/user_model/user_model.dart';
import 'package:weider/features/user/presentation/controllers/add_new_user/add_new_user_cubit.dart';

import '../../../../core/constants/intervals/intervals.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/uesr_image/user_image_cubit.dart';

///* userModel is a model that i will modify it
class AddEditUserScreen extends StatefulWidget {
  const AddEditUserScreen({super.key, this.userModel});
  final UserModel? userModel;

  @override
  State<AddEditUserScreen> createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  String? imagePath;

  late GlobalKey<FormState> formState;
  late TextEditingController nameController,
      startController,
      phoneController,
      intervalController,
      priceController,
      noteController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userModel?.name);
    startController = TextEditingController(
      text: widget.userModel?.startDate.toString().split(' ')[0],
    );
    phoneController = TextEditingController(text: widget.userModel?.phone);
    intervalController = TextEditingController(
      text: widget.userModel?.intervalTime?.intervalName,
    );
    priceController = TextEditingController(
      text: widget.userModel?.price.toStringAsFixed(1),
    );
    noteController = TextEditingController(text: widget.userModel?.note);
    formState = GlobalKey();
  }

  @override
  void dispose() {
    nameController.dispose();
    startController.dispose();
    phoneController.dispose();
    intervalController.dispose();
    priceController.dispose();
    noteController.dispose();
    super.dispose();
  }

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
                widget.userModel != null ? "تعديل البيانات" : "إضافة عضو",
                style: context.semiB16.copyWith(color: AppColors.onPrimary),
              ),
              actionsPadding: EdgeInsets.only(left: 10),
              actions: [
                BlocListener<UserImageCubit, String?>(
                  listener: (context, state) {
                    imagePath = state;
                    log("image path listener $imagePath");
                  },
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(16),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      saveUser(context);
                    },
                    child: Text("حفظ"),
                  ),
                ),
              ],
            ),
            body: UserBodyInputs(
              userModel: widget.userModel,
              formState: formState,
              nameController: nameController,
              startController: startController,
              phoneController: phoneController,
              intervalController: intervalController,
              priceController: priceController,
              noteController: noteController,
            ),
          );
        },
      ),
    );
  }

  void saveUser(BuildContext context) {
    if (formState.currentState!.validate()) {
      UserModel user = widget.userModel != null
          ? widget.userModel!.copyWith(
              name: nameController.text,
              startDate: DateTime.parse(startController.text),
              phone: phoneController.text,
              price: double.tryParse(priceController.text.split(' ')[0]),
              note: noteController.text,
              intervalTime: Intervals.values.firstWhere(
                (interval) => interval.intervalName == intervalController.text,
                orElse: () => Intervals.month,
              ),
              imagePath: imagePath,
            )
          : UserModel.create(
              name: nameController.text,
              startDate: DateTime.parse(startController.text),
              phone: phoneController.text,
              price: double.tryParse(priceController.text.split(' ')[0]) ?? 200,
              intervalTime: Intervals.values.firstWhere(
                (interval) => interval.intervalName == intervalController.text,
                orElse: () => Intervals.month,
              ),
              imagePath: imagePath,
              note: noteController.text,
            );
      context.read<AddEditUserCubit>().addEditUser(newUser: user);
      Navigator.pop(context);
      log("User : ${user.toString()} added");
    }
  }
}
