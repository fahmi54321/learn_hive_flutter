// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hewan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HewanAdapter extends TypeAdapter<Hewan> {
  @override
  final int typeId = 1;

  @override
  Hewan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hewan(
      kategori: fields[0] as String,
      hewans: (fields[1] as HiveList).castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, Hewan obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.kategori)
      ..writeByte(1)
      ..write(obj.hewans);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HewanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HewanListAdapter extends TypeAdapter<HewanList> {
  @override
  final int typeId = 2;

  @override
  HewanList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HewanList(
      nama: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HewanList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.nama);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HewanListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
