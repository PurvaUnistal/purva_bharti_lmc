// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageDataModelAdapter extends TypeAdapter<ImageDataModel> {
  @override
  final int typeId = 0;

  @override
  ImageDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageDataModel(
      bpNumber: fields[0] as String,
      lmcID: fields[1] as String,
      dmaID: fields[2] as String,
      image1: fields[3] as String,
      image2: fields[4] as String,
      image3: fields[5] as String,
      image4: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ImageDataModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.bpNumber)
      ..writeByte(1)
      ..write(obj.lmcID)
      ..writeByte(2)
      ..write(obj.dmaID)
      ..writeByte(3)
      ..write(obj.image1)
      ..writeByte(4)
      ..write(obj.image2)
      ..writeByte(5)
      ..write(obj.image3)
      ..writeByte(6)
      ..write(obj.image4);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
