import 'package:hive/hive.dart';
part 'ticket_model.g.dart';


@HiveType(typeId: 2)
class TicketType extends HiveObject{

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String typeName;

  @HiveField(2)
  final String price;

  @HiveField(3)
  final int count;

  @HiveField(4)
  final int soldCount;

  @HiveField(5)
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