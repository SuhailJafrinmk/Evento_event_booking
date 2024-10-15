import 'dart:convert';

class BookedTicketModel {
  final int id; // Read-only
  final String organizerName; // Read-only
  final String eventName; // Read-only
  final String typeName; // Read-only
  final DateTime eventDate; // Read-only
  final String ticketPrice; // Required
  final int ticketCount; // Required, min 0, max 2147483647
  final String? qrCode; // Read-only, Nullable
  final DateTime bookingDate; // Read-only
  final String ticketStatus; // Enum, Read-only
  final int ticketType; // Required
  final int user; // Required

  BookedTicketModel({
    required this.id,
    required this.organizerName,
    required this.eventName,
    required this.typeName,
    required this.eventDate,
    required this.ticketPrice,
    required this.ticketCount,
    this.qrCode,
    required this.bookingDate,
    required this.ticketStatus,
    required this.ticketType,
    required this.user,
  });

  // Factory method to create a BookedTicketModel object from JSON
  factory BookedTicketModel.fromJson(Map<String, dynamic> json) {
    return BookedTicketModel(
      id: json['id'],
      organizerName: json['organizer_name'],
      eventName: json['event_name'],
      typeName: json['type_name'],
      eventDate: DateTime.parse(json['event_date']),
      ticketPrice: json['ticket_price'],
      ticketCount: json['ticket_count'],
      qrCode: json['qr_code'],
      bookingDate: DateTime.parse(json['booking_date']),
      ticketStatus: json['ticket_status'],
      ticketType: json['ticket_type'],
      user: json['user'],
    );
  }

  // Method to convert a BookedTicketModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizer_name': organizerName,
      'event_name': eventName,
      'type_name': typeName,
      'event_date': eventDate.toIso8601String(),
      'ticket_price': ticketPrice,
      'ticket_count': ticketCount,
      'qr_code': qrCode,
      'booking_date': bookingDate.toIso8601String(),
      'ticket_status': ticketStatus,
      'ticket_type': ticketType,
      'user': user,
    };
  }
}

