import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weider/core/theme/app_colors.dart';

class CustomTextInputField extends StatelessWidget {
  const CustomTextInputField({
    super.key,
    required this.controller,
    required this.label,
    this.initValue,
    this.isDate = false,
    this.onTap,
    this.keyboardType,
    this.inputFormatters, this.validator, this.onChanged ,
  });
  final TextEditingController controller;
  final String label;
  final String? initValue;
  final bool isDate;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: AppColors.backgroundLight),
      onTap: isDate ? onTap : null,
      keyboardType: keyboardType,
      
      readOnly: isDate,
      validator: validator,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: label,

        suffixIcon: isDate
            ? Icon(
                Icons.calendar_month_outlined,
                color: AppColors.backgroundLight,
              )
            : null,
      ),
      initialValue: initValue,
    );
  }
}
