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
    this.maxLines,
    this.isSearch = false,
  });
  final TextEditingController controller;
  final String label;
  final bool isDate;
  final bool isSearch;
  final bool isModify;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function()? onCompleteWriting;
  final int? maxLines;

  @override
  State<CustomTextInputField> createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  late bool readOnly;
  bool isArabic = true;
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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: widget.onCompleteWriting,
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      maxLines: widget.maxLines,
      // minLines: 1,
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
        // isDense: true,

        // contentPadding: EdgeInsets.fromLTRB(8, 2, 8, 2),
        hintStyle: context.med14.copyWith(color: AppColors.accentLight),
        suffixIcon: _buildSuffixIcon(),
      ),
    );
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
    if (widget.isSearch) {
      return Icon(Icons.search, color: AppColors.accentLight, size: 24);
    }
    // الحالة 3: الحقل قابل للتعديل أصلاً → مفيش داعي لأيقونات
    return null;
  }
}
