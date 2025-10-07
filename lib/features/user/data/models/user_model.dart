import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:weider/core/constants/intervals.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
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
  final String phone;

  @HiveField(6)
  final Intervals intervalTime;

  UserModel({
    required this.id,
    this.imagePath,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.phone,
    required this.intervalTime,
  });

  factory UserModel.create({
    required String name,
    String? imagePath,
    required DateTime startDate,
    required String phone,
    required Intervals intervalTime,
  }) {
    final DateTime endDateTime = switch (intervalTime) {
      Intervals.month => startDate.add(Duration(days: 30)),
      Intervals.threeMonth => startDate.add(Duration(days: 90)),
      Intervals.sixMonth => startDate.add(Duration(days: 180)),
      Intervals.year => startDate.add(Duration(days: 365)),
    };

    return UserModel(
      id: Uuid().v1(),
      name: name,
      startDate: startDate,
      endDate: endDateTime,
      imagePath: imagePath,
      phone: phone,
      intervalTime: intervalTime,
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
    );
  }

  UserModel copyWith({
    String? id,
    String? imagePath,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    String? phone,
    Intervals? intervalTime,
  }) {
    return UserModel(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      phone: phone ?? this.phone,
      intervalTime: intervalTime ?? this.intervalTime,
    );
  }
}
