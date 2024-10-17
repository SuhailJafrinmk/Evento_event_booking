import 'package:evento_event_booking/models/booked_ticket_model.dart';

class UserProfile {
  final String username;
  final String email;
  final String phoneNumber;
  final String profilePicture;
  final List<BookedTicketModel> tickets;

  UserProfile({
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.tickets,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      profilePicture: json['profile_picture'],
      tickets: (json['tickets'] as List)
          .map((ticketJson) => BookedTicketModel.fromJson(ticketJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'profile_picture': profilePicture,
      'tickets': tickets.map((ticket) => ticket.toJson()).toList(),
    };
  }
}




