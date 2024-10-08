// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventModelAdapter extends TypeAdapter<EventModel> {
  @override
  final int typeId = 1;

  @override
  EventModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventModel(
      id: fields[0] as int,
      event_name: fields[1] as String,
      start_date: fields[2] as String,
      end_date: fields[3] as String,
      time: fields[4] as String,
      venue: fields[5] as String?,
      location: fields[6] as String?,
      event_img_1: fields[7] as String?,
      event_img_2: fields[8] as String?,
      event_img_3: fields[9] as String?,
      about: fields[10] as String?,
      instruction: fields[11] as String?,
      termsAndConditions: fields[12] as String?,
      vendor: fields[13] as String?,
      status: fields[14] as String,
      location_url: fields[15] as String?,
      organizer_id: fields[16] as String?,
      organizer_name: fields[17] as String?,
      organizer_email: fields[18] as String?,
      organizer_phone: fields[19] as String?,
      organizer_profile_photo: fields[20] as String?,
      ticket_types: (fields[21] as List?)?.cast<TicketType>(),
    );
  }

  @override
  void write(BinaryWriter writer, EventModel obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.event_name)
      ..writeByte(2)
      ..write(obj.start_date)
      ..writeByte(3)
      ..write(obj.end_date)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.venue)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.event_img_1)
      ..writeByte(8)
      ..write(obj.event_img_2)
      ..writeByte(9)
      ..write(obj.event_img_3)
      ..writeByte(10)
      ..write(obj.about)
      ..writeByte(11)
      ..write(obj.instruction)
      ..writeByte(12)
      ..write(obj.termsAndConditions)
      ..writeByte(13)
      ..write(obj.vendor)
      ..writeByte(14)
      ..write(obj.status)
      ..writeByte(15)
      ..write(obj.location_url)
      ..writeByte(16)
      ..write(obj.organizer_id)
      ..writeByte(17)
      ..write(obj.organizer_name)
      ..writeByte(18)
      ..write(obj.organizer_email)
      ..writeByte(19)
      ..write(obj.organizer_phone)
      ..writeByte(20)
      ..write(obj.organizer_profile_photo)
      ..writeByte(21)
      ..write(obj.ticket_types);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
