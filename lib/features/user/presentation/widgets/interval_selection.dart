import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:weider/core/responsive/device_info.dart';
import 'package:weider/core/theme/app_colors.dart';

import '../../../../core/constants/intervals.dart';

typedef IntervalS = DropdownMenuEntry<int>;


List<IntervalS> entries = UnmodifiableListView(
  Intervals.values.map((intervals) {
    return IntervalS(
      label: intervals.intervalName,
      value: intervals.intervalByMonth,
      style: MenuItemButton.styleFrom(
        // backgroundColor: Colors.blue, // لون العنصر
        foregroundColor: Colors.white, // لون النص
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
        ),

        // side: BorderSide(color: Colors.white)
      ),
    );
  }),
);

class IntervalSelection extends StatelessWidget {
  const IntervalSelection({super.key, this.onSelected, required this.intervalController, this.initSelection = 1});
  final void Function(int?)? onSelected;
  final TextEditingController intervalController;
  final int? initSelection;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<int>(
      dropdownMenuEntries: entries,
      controller: intervalController,
      initialSelection: initSelection,
      onSelected: onSelected,
      
      width: DeviceInfo.screenWidth(context),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        fillColor: AppColors.primaryColor,
        filled: true,
      ),
      hintText: "مدة الاشتراك",
      textStyle: TextStyle(color: AppColors.backgroundLight),
      enableFilter: true,

      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),

        fixedSize: WidgetStatePropertyAll(
          Size.fromWidth(DeviceInfo.screenWidth(context)) * .88,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),

        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20)),
      ),
    );
  }
}
