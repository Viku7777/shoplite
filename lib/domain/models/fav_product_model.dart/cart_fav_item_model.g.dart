// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_fav_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartFavItemModelAdapter extends TypeAdapter<CartFavItemModel> {
  @override
  final int typeId = 3;

  @override
  CartFavItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartFavItemModel(
      fields[0] as ProductModels,
      fields[1] as int,
      fields[2] as bool,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CartFavItemModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.productModel)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.isFav)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartFavItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
