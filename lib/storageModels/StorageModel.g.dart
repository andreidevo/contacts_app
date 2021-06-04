// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StorageModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StorageModelAdapter extends TypeAdapter<StorageModel> {
  @override
  final int typeId = 0;

  @override
  StorageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StorageModel(
      data: fields[0] as String,
      time: fields[1] as String,
      countContacts: fields[2] as String,
      fileMemory: fields[3] as String,
      pathFileVcf: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StorageModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.countContacts)
      ..writeByte(3)
      ..write(obj.fileMemory)
      ..writeByte(4)
      ..write(obj.pathFileVcf);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StorageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
