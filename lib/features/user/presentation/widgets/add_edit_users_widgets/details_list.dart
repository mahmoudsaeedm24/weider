import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weider/core/constants/reg_ex.dart';
import 'package:weider/features/user/presentation/widgets/add_edit_users_widgets/custom_text_input_field.dart';
import 'package:weider/features/user/presentation/controllers/add_new_user/add_new_user_cubit.dart';
import 'package:weider/features/user/presentation/widgets/add_edit_users_widgets/interval_selection.dart';

import '../../../../../core/constants/intervals/intervals.dart';
import '../../../data/models/user_model/user_model.dart';
import '../../controllers/uesr_image/user_image_cubit.dart';

class DetailsList extends StatefulWidget {
  const DetailsList({super.key, this.userModel});
  final UserModel? userModel;
  @override
  State<DetailsList> createState() => _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {
  String? imagePath;

  late GlobalKey<FormState> formState;
  late TextEditingController nameController,
      startController,
      phoneController,
      intervalController,
      priceController;
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
    formState = GlobalKey();
  }

  @override
  void dispose() {
    nameController.dispose();
    startController.dispose();
    phoneController.dispose();
    intervalController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Future<DateTime> _subDate() async {
    final currDate = DateTime.now();
    return await showDatePicker(
          context: context,
          firstDate: currDate.subtract(Duration(days: 2 * 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          initialDate: widget.userModel?.startDate,
        ) ??
        widget.userModel?.startDate ??
        currDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Form(
        key: formState,
        child: Column(
          spacing: 24,

          children: <Widget>[
            CustomTextInputField(
              controller: nameController,
              label: "الاسم",
              isModify: widget.userModel == null,
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return "يجب أن تدخل اسم المستخدم";
                }
                if (!RegEx.nameExpression.hasMatch(input)) {
                  return "ادخل اسم مستخدم لا يحتوي علي رموز";
                }
                return null;
              },
            ),
            CustomTextInputField(
              controller: startController,
              isDate: true,
              isModify: widget.userModel == null,
              onTap: () async {
                final DateTime initDateTime = await _subDate();
                startController.text = initDateTime.toString().split(' ')[0];
              },
              label: "بداية الاشتراك",
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return "يرجي إدخال بداية الاشتراك";
                }
                return null;
              },
            ),
            CustomTextInputField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              label: "رقم الهاتف",
              isModify: widget.userModel == null,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
              ],
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return null;
                } else if (input.length < 11) {
                  return "ادخل رقم هاتف صالح";
                }
                return null;
              },
            ),

            IntervalSelection(
              intervalController: intervalController,
              initSelection: widget.userModel?.intervalTime?.intervalByMonth,
            ),

            CustomTextInputField(
              controller: priceController,
              keyboardType: TextInputType.phone,
              label: "سعر الاشتراك",
              isModify: widget.userModel == null,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return "يرجي إدخال سعر الاشتراك";
                }

                return null;
              },
            ),
            SizedBox(height: 30),
            BlocListener<UserImageCubit, String?>(
              listener: (context, state) {
                imagePath = state;
              },
              child: ElevatedButton(
                onPressed: () async {
                  saveUser(context);
                },
                child: Text("حفظ"),
              ),
            ),
          ],
        ),
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
            );
      context.read<AddEditUserCubit>().addEditUser(newUser: user);
      Navigator.pop(context);
      log("User : ${user.toString()} added");
    }
  }
}
