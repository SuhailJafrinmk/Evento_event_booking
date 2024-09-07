class EventModel {
  final int id;
  final String event_name;
  final String start_date;
  final String end_date;
  final String time;
  final String? venue;
  final String? location;
  final String? event_img_1;
  final String? event_img_2;
  final String? event_img_3;
  final String? about;
  final String? instruction;
  final String? termsAndConditions;
  final String? vendor;
  final String status;
  final String? location_url;
  final String? organizer_id;
  final String? organizer_name;
  final String? organizer_email;
  final String? organizer_phone;
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
        start_date: _parseString(json, 'start_date'),
        end_date: _parseString(json, 'end_date'),
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


// class TicketType {
//   final String id;
//   final String type_name;
//   final String? ticket_image;
//   final String price;
//   final int count;
//   final String sold_count;
//   final int event;

//   TicketType({
//     required this.id,
//     required this.type_name,
//     this.ticket_image,
//     required this.price,
//     required this.count,
//     required this.sold_count,
//     required this.event,
//   });

//   factory TicketType.fromJson(Map<String, dynamic> json) {
//     return TicketType(
//       id: json['id'],
//       type_name: json['type_name'],
//       ticket_image: json['ticket_image'],
//       price: json['price'],
//       count: json['count'],
//       sold_count: json['sold_count'],
//       event: json['event'],
//     );
//   }
// }
