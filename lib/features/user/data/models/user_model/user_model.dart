import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:weider/core/constants/intervals/intervals.dart';
import 'package:weider/core/utils/end_date_calc.dart';

import '../../../../../core/constants/adapter_keys.dart';

part 'user_model.g.dart';

@HiveType(typeId: AdapterKeys.userModel)
class UserModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? imagePath;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final DateTime startDate;

  @HiveField(4)
  final DateTime endDate;

  @HiveField(5)
  final String? phone;

  @HiveField(6)
  final Intervals? intervalTime;

  @HiveField(7)
  final double price;

  UserModel({
    required this.id,
    this.imagePath,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.phone,
    this.intervalTime = Intervals.month,
    required this.price,
  });

  factory UserModel.create({
    required String name,
    String? imagePath,
    required DateTime startDate,
    required String? phone,
    required Intervals intervalTime,
    required double price,
  }) {
    return UserModel(
      id: Uuid().v1(),
      name: name,
      startDate: startDate,
      endDate: endDateCalc(startDate, intervalTime),
      imagePath: imagePath,
      phone: phone,
      intervalTime: intervalTime,
      price: price,
    );
  }

  factory UserModel.mock() {
    return UserModel(
      id: "123",
      name: "محمود سعيد سالم",
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 30)),
      phone: "01552483586",
      intervalTime: Intervals.threeMonth,
      price: 200,
    );
  }

  UserModel copyWith({
    String? id,
    String? imagePath,
    String? name,
    DateTime? startDate,
    String? phone,
    Intervals? intervalTime,
    double? price,
  }) {
    return UserModel(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDateCalc(
        startDate ?? this.startDate,
        intervalTime ?? this.intervalTime!,
      ),
      phone: phone ?? this.phone,
      intervalTime: intervalTime ?? this.intervalTime,
      price: price ?? this.price,
    );
  }
}
