// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketTypeAdapter extends TypeAdapter<TicketType> {
  @override
  final int typeId = 2;

  @override
  TicketType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TicketType(
      id: fields[0] as int,
      typeName: fields[1] as String,
      price: fields[2] as String,
      count: fields[3] as int,
      soldCount: fields[4] as int,
      ticketImage: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TicketType obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.typeName)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.count)
      ..writeByte(4)
      ..write(obj.soldCount)
      ..writeByte(5)
      ..write(obj.ticketImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
