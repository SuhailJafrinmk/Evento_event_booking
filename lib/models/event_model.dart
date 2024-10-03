import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
part 'event_model.g.dart'; // Hive generates this part file

@HiveType(typeId: 1) // Assign a unique typeId for this class
class EventModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String event_name;

  @HiveField(2)
  final String start_date;

  @HiveField(3)
  final String end_date;

  @HiveField(4)
  final String time;

  @HiveField(5)
  final String? venue;

  @HiveField(6)
  final String? location;

  @HiveField(7)
  final String? event_img_1;

  @HiveField(8)
  final String? event_img_2;

  @HiveField(9)
  final String? event_img_3;

  @HiveField(10)
  final String? about;

  @HiveField(11)
  final String? instruction;

  @HiveField(12)
  final String? termsAndConditions;

  @HiveField(13)
  final String? vendor;

  @HiveField(14)
  final String status;

  @HiveField(15)
  final String? location_url;

  @HiveField(16)
  final String? organizer_id;

  @HiveField(17)
  final String? organizer_name;

  @HiveField(18)
  final String? organizer_email;

  @HiveField(19)
  final String? organizer_phone;

  @HiveField(20)
  final String? organizer_profile_photo;

  EventModel({
    required this.id,
    required this.event_name,
    required this.start_date,
    required this.end_date,
    required this.time,
    this.venue,
    this.location,
    this.event_img_1,
    this.event_img_2,
    this.event_img_3,
    this.about,
    this.instruction,
    this.termsAndConditions,
    this.vendor,
    required this.status,
    this.location_url,
    this.organizer_id,
    this.organizer_name,
    this.organizer_email,
    this.organizer_phone,
    this.organizer_profile_photo,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    try {
      return EventModel(
        id: json['id'],
        event_name: _parseString(json, 'event_name'),
        start_date: parseAndFormatDate(json, 'start_date'),
        end_date: parseAndFormatDate(json, 'end_date'),
        time: _parseString(json, 'time'),
        venue: _parseNullableString(json, 'venue'),
        location: _parseNullableString(json, 'location'),
        event_img_1: _parseNullableString(json, 'event_img_1'),
        event_img_2: _parseNullableString(json, 'event_img_2'),
        event_img_3: _parseNullableString(json, 'event_img_3'),
        about: _parseNullableString(json, 'about'),
        instruction: _parseNullableString(json, 'instruction'),
        termsAndConditions: _parseNullableString(json, 'terms_and_conditions'),
        vendor: _parseNullableString(json, 'vendor'),
        status: _parseString(json, 'status'),
        location_url: _parseNullableString(json, 'location_url'),
        organizer_id: _parseNullableString(json, 'organizer_id'),
        organizer_name: _parseNullableString(json, 'organizer_name'),
        organizer_email: _parseNullableString(json, 'organizer_email'),
        organizer_phone: _parseNullableString(json, 'organizer_phone'),
        organizer_profile_photo: _parseNullableString(json, 'organizer_profile_photo'),
      );
    } catch (e, stacktrace) {
      print("Error parsing EventModel: $e");
      print(stacktrace);
      rethrow;
    }
  }

static String parseAndFormatDate(Map<String, dynamic> json, String key) {
  try {
    final dateString = json[key] as String; // Extract the string value from the JSON
    DateTime dateTime = DateTime.parse(dateString).toLocal(); // Parse the ISO 8601 date and convert to local time
    return DateFormat('dd MMMM yyyy, hh:mm a').format(dateTime); // Format the DateTime
  } catch (e) {
    throw Exception("Error parsing date for key '$key': $e");
  }
}


  static String _parseString(Map<String, dynamic> json, String key) {
    try {
      return json[key] as String;
    } catch (e) {
      throw Exception("Error parsing field '$key': $e");
    }
  }

  static String? _parseNullableString(Map<String, dynamic> json, String key) {
    try {
      return json[key] != null ? json[key] as String : null;
    } catch (e) {
      throw Exception("Error parsing nullable field '$key': $e");
    }
  }
}


class TicketType {
  final int id;
  final String typeName;
  final String price;
  final int count;
  final int soldCount;
  final String? ticketImage;

  TicketType({
    required this.id,
    required this.typeName,
    required this.price,
    required this.count,
    required this.soldCount,
    this.ticketImage,
  });

  factory TicketType.fromMap(Map<String, dynamic> map) {
    return TicketType(
      id: map['id'],
      typeName: map['type_name'],
      price: map['price'],
      count: map['count'],
      soldCount: map['sold_count'],
      ticketImage: map['ticket_image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type_name': typeName,
      'price': price,
      'count': count,
      'sold_count': soldCount,
      'ticket_image': ticketImage,
    };
  }
}
