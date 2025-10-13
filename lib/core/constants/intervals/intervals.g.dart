// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intervals.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IntervalsAdapter extends TypeAdapter<Intervals> {
  @override
  final int typeId = 0;

  @override
  Intervals read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Intervals.month;
      case 1:
        return Intervals.threeMonth;
      case 2:
        return Intervals.sixMonth;
      case 3:
        return Intervals.year;
      default:
        return Intervals.month;
    }
  }

  @override
  void write(BinaryWriter writer, Intervals obj) {
    switch (obj) {
      case Intervals.month:
        writer.writeByte(0);
        break;
      case Intervals.threeMonth:
        writer.writeByte(1);
        break;
      case Intervals.sixMonth:
        writer.writeByte(2);
        break;
      case Intervals.year:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntervalsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
