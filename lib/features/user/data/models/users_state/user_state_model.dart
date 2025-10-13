// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:weider/core/constants/adapter_keys.dart';
import 'package:weider/features/user/data/models/user_model/user_model.dart';
part 'user_state_model.g.dart';
@HiveType(typeId: AdapterKeys.userStateModel)
class UserStateModel extends HiveObject {
  @HiveField(0)
  final List<UserModel> active;

    @HiveField(1)
  final List<UserModel> deactive;
  UserStateModel({
    required this.active,
    required this.deactive,
  });

  UserStateModel copyWith({
    List<UserModel>? active,
    List<UserModel>? deactive,
  }) {
    return UserStateModel(
      active: active ?? this.active,
      deactive: deactive ?? this.deactive,
    );
  }

  @override
  String toString() => 'UserStateModel(active: $active, deactive: $deactive)';

  @override
  bool operator ==(covariant UserStateModel other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.active, active) &&
      listEquals(other.deactive, deactive);
  }

  @override
  int get hashCode => active.hashCode ^ deactive.hashCode;
}
