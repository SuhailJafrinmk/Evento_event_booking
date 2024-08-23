// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EventLocations {
  final int id;
  final String name;
  EventLocations({
    required this.id,
    required this.name,
  });

  EventLocations copyWith({
    int? id,
    String? name,
  }) {
    return EventLocations(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory EventLocations.fromMap(Map<String, dynamic> map) {
    return EventLocations(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventLocations.fromJson(String source) => EventLocations.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EventLocations(id: $id, name: $name)';

  @override
  bool operator ==(covariant EventLocations other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
