// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserStateModelAdapter extends TypeAdapter<UserStateModel> {
  @override
  final int typeId = 2;

  @override
  UserStateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserStateModel(
      active: (fields[0] as List).cast<UserModel>(),
      deactive: (fields[1] as List).cast<UserModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserStateModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.active)
      ..writeByte(1)
      ..write(obj.deactive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
