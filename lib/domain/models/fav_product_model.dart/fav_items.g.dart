// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_items.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavItemsModelAdapter extends TypeAdapter<FavItemsModel> {
  @override
  final int typeId = 5;

  @override
  FavItemsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavItemsModel(
      fields[0] as ProductModels,
      fields[1] as bool,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavItemsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.productModel)
      ..writeByte(1)
      ..write(obj.isFav)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavItemsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
