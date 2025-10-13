import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weider/core/extension/text_style_on_context.dart';
import 'package:weider/core/theme/app_colors.dart';

class CustomTextInputField extends StatefulWidget {
  const CustomTextInputField({
    super.key,
    required this.controller,
    required this.label,
    this.isDate = false,
    this.onTap,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onCompleteWriting,
    this.isModify = true,
  });
  final TextEditingController controller;
  final String label;
  final bool isDate;
  final bool isModify;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function()? onCompleteWriting;

  @override
  State<CustomTextInputField> createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  late bool readOnly;
  late bool modifiedComplete = false;
  bool autofocus = false;
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    readOnly = widget.isDate || !widget.isModify;
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Widget? _buildSuffixIcon() {
    if (widget.isDate) {
      // الحالة 1: الحقل خاص بالتاريخ
      return Icon(Icons.calendar_month_outlined, color: AppColors.accentLight);
    }

    if (!widget.isModify) {
      // الحالة 2: الحقل غير قابل للتعديل
      return readOnly
          ? IconButton(
              onPressed: () {
                setState(() {
                  readOnly = false;
                });
                Future.delayed(Duration(milliseconds: 100), () {
                  _focusNode.requestFocus();
                });
              },
              icon: Icon(Icons.edit_outlined, color: AppColors.accentLight),
            )
          : IconButton(
              onPressed: () {
                setState(() {
                  readOnly = true;
                });

                _focusNode.unfocus();
              },
              icon: Icon(Icons.check, color: AppColors.secondary),
            );
    }

    // الحالة 3: الحقل قابل للتعديل أصلاً → مفيش داعي لأيقونات
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: widget.onCompleteWriting,
      controller: widget.controller,
      style: TextStyle(color: AppColors.onPrimary),
      onTap: widget.isDate ? widget.onTap : null,
      keyboardType: widget.keyboardType,
      cursorColor: AppColors.secondary,
      autofocus: autofocus,
      focusNode: _focusNode,
      readOnly: readOnly,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.label,
        hintStyle: context.med14.copyWith(color: AppColors.accentLight),
        suffixIcon: _buildSuffixIcon(),
      ),
    );
  }
}
