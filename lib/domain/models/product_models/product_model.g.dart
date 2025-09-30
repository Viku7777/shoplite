// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelsAdapter extends TypeAdapter<ProductModels> {
  @override
  final int typeId = 2;

  @override
  ProductModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModels(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      discountPercentage: fields[3] as num,
      price: fields[4] as num,
      rating: fields[5] as num,
      shippingInformation: fields[6] as String,
      images: (fields[7] as List).cast<dynamic>(),
      thumbnail: fields[8] as String,
      quantity: fields[9] as int,
      isFav: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModels obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.discountPercentage)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.shippingInformation)
      ..writeByte(7)
      ..write(obj.images)
      ..writeByte(8)
      ..write(obj.thumbnail)
      ..writeByte(9)
      ..write(obj.quantity)
      ..writeByte(10)
      ..write(obj.isFav);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
