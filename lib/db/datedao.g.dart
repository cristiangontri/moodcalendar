// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datedao.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DateDaoAdapter extends TypeAdapter<DateDao> {
  @override
  final int typeId = 1;

  @override
  DateDao read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DateDao(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
      fields[3] as String,
    ).._note = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, DateDao obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj._day)
      ..writeByte(1)
      ..write(obj._month)
      ..writeByte(2)
      ..write(obj._year)
      ..writeByte(3)
      ..write(obj._emotion)
      ..writeByte(4)
      ..write(obj._note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateDaoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
