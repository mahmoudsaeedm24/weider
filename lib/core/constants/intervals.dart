import 'package:hive_flutter/hive_flutter.dart';

part 'intervals.g.dart';

@HiveType(typeId: 0)
enum Intervals {
  @HiveField(0)
  month("1 شهر", 1),

  @HiveField(1)
  threeMonth("3 شهر", 3),

  @HiveField(2)
  sixMonth("6 شهر", 6),

  @HiveField(3)
  year("12 شهر", 12);

  final String intervalName;
  final int intervalByMonth;
  const Intervals(this.intervalName, this.intervalByMonth);
}
