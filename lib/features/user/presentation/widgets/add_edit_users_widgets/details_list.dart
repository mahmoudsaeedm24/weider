import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weider/core/constants/reg_ex.dart';
import 'package:weider/features/user/presentation/widgets/add_edit_users_widgets/interval_selection.dart';
import 'package:weider/features/user/presentation/widgets/add_edit_users_widgets/text_input/custom_text_input_field.dart';

import '../../../data/models/user_model/user_model.dart';

class DetailsList extends StatefulWidget {
  const DetailsList({super.key, this.userModel, required this.formState, required this.nameController, required this.startController, required this.phoneController, required this.intervalController, required this.priceController, required this.noteController});
  final UserModel? userModel;
    final  GlobalKey<FormState> formState;
  final TextEditingController nameController,
      startController,
      phoneController,
      intervalController,
      priceController,
      noteController;
  @override
  State<DetailsList> createState() => _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {
  late bool addNote;

  @override
  void initState() {
    super.initState();
    addNote = widget.userModel?.note == null;
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
        key: widget.formState,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,

          children: <Widget>[
            //* الاسم
            CustomTextInputField(
              controller: widget.nameController,
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
            //* بداية الاشتراك
            CustomTextInputField(
              controller: widget.startController,
              isDate: true,
              isModify: widget.userModel == null,
              onTap: () async {
                final DateTime initDateTime = await _subDate();
                widget.startController.text = initDateTime.toString().split(' ')[0];
              },
              label: "بداية الاشتراك",
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return "يرجي إدخال بداية الاشتراك";
                }
                return null;
              },
            ),
            //* رقم الهاتف
            CustomTextInputField(
              controller: widget.phoneController,
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
            //* مدة الاشتراك
            IntervalSelection(
              intervalController: widget.intervalController,
              initSelection: widget.userModel?.intervalTime?.intervalByMonth,
            ),
            //* سعر الاشتراك
            CustomTextInputField(
              controller: widget.priceController,
              keyboardType: TextInputType.phone,
              label: "سعر الاشتراك",
              isModify: widget.userModel == null,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
            ),
            if (!addNote)
              CustomTextInputField(
                controller: widget.noteController,
                label: "اكتب ملاحظاتك",
                isModify: widget.userModel == null,
              ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (!addNote) {
                    widget.noteController.clear();
                  }

                  addNote = !addNote;
                });
              },
              child: Text(addNote ? "إضافة ملاحظات" : "حذف الملاحظة"),
            ),

            
          ],
        ),
      ),
    );
  }

  
}
