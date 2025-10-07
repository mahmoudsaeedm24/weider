import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weider/core/shared/widget/custom_text_input_field.dart';
import 'package:weider/features/user/presentation/controllers/add_new_user/add_new_user_cubit.dart';
import 'package:weider/features/user/presentation/widgets/interval_selection.dart';

import '../../../../core/constants/intervals.dart';
import '../../data/models/user_model.dart';
import '../controllers/uesr_image/user_image_cubit.dart';

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
      intervalController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userModel?.name);
    startController = TextEditingController(text: widget.userModel?.startDate.toString().split(' ')[0]);
    phoneController = TextEditingController(text: widget.userModel?.phone);
    intervalController = TextEditingController(text: widget.userModel?.intervalTime.intervalName);

    formState = GlobalKey();
  }

  @override
  void dispose() {
    nameController.dispose();
    startController.dispose();
    phoneController.dispose();
    intervalController.dispose();
    super.dispose();
  }

  Future<DateTime> _subDate() async {
    final currDate = DateTime.now();
    return await showDatePicker(
          context: context,
          firstDate: currDate.subtract(Duration(days: 2 * 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          initialDate: currDate,
        ) ??
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

          children: [
            CustomTextInputField(
              controller: nameController,
              label: "الاسم",
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^[a-zA-Z\u0621-\u064A ]+$'),
                ),
              ],
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return "يجب أن تدخل اسم المستخدم";
                }
                return null;
              },
            ),
            CustomTextInputField(
              controller: startController,
              isDate: true,

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
            // CustomTextInputField(
            //   controller: endController,
            //   isDate: true,
            //   onTap: () async {
            //     final DateTime? initDateTime = await _subDate();
            //     endController.text = initDateTime == null
            //         ? ""
            //         : initDateTime.toString().split(' ')[0];
            //   },
            //   label: "نهاية الاشتراك",
            // ),
            CustomTextInputField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              label: "رقم الهاتف",
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
              ],
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return "يرجي إدخال رقم الهاتف";
                }
                return null;
              },
            ),
            // CustomTextInputField(controller: intervalController, label: "المدة", onTap: () {

            // },),
            IntervalSelection(intervalController: intervalController, initSelection: widget.userModel?.intervalTime.intervalByMonth,),
            SizedBox(height: 30),
            BlocListener<UserImageCubit, String?>(
              listener: (context, state) {
                imagePath = state;
              },
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (formState.currentState!.validate()) {
                    UserModel user = widget.userModel != null ?widget.userModel!.copyWith(
                      name: nameController.text,
                      startDate: DateTime.parse(startController.text),
                      phone: phoneController.text,
                      intervalTime: Intervals.values.firstWhere(
                        (interval) =>
                            interval.intervalName == intervalController.text,
                        orElse: () => Intervals.month,
                      ),
                      imagePath: imagePath,
                    ) : UserModel.create(
                      name: nameController.text,
                      startDate: DateTime.parse(startController.text),
                      phone: phoneController.text,
                      intervalTime: Intervals.values.firstWhere(
                        (interval) =>
                            interval.intervalName == intervalController.text,
                        orElse: () => Intervals.month,
                      ),
                      imagePath: imagePath,
                    );
                    context
                        .read<AddEditUserCubit>()
                        .addEditUser(newUser: user);
                          Navigator.pop(context);
                    log("User : ${user.toString()} added");
                  }
                },
                label: Text("حفظ"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
