import 'package:hive/hive.dart';
import 'package:evento_event_booking/models/booked_ticket_model.dart';
// part 'user_profile_model.g.dart';

@HiveType(typeId: 3) // Assign a unique typeId for each class
class UserProfile {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String phoneNumber;

  @HiveField(3)
  final String? profilePicture;

  @HiveField(4)
  final List<BookedTicketModel>? tickets;

  UserProfile({
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.tickets,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'] ?? 'Guest',
      email: json['email'] ?? 'guest@gmail.com',
      phoneNumber: json['phone_number'] ?? 'not provided',
      profilePicture: json['profile_picture'],
      tickets: (json['tickets'] as List?)
          ?.map((ticketJson) => BookedTicketModel.fromJson(ticketJson))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'profile_picture': profilePicture,
      'tickets': tickets?.map((ticket) => ticket.toJson()).toList() ?? [],
    };
  }
}




