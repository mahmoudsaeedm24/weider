import 'package:weider/core/constants/intervals/intervals.dart';

DateTime endDateCalc(DateTime startDate, Intervals intervalTime){
      return switch (intervalTime) {
      Intervals.month => startDate.add(Duration(days: 30)),
      Intervals.threeMonth => startDate.add(Duration(days: 90)),
      Intervals.sixMonth => startDate.add(Duration(days: 180)),
      Intervals.year => startDate.add(Duration(days: 365)),
    };
}