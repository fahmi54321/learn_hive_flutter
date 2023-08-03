// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'contacts.g.dart';

@HiveType(typeId: 1)
enum Relationship {
  @HiveField(0)
  family,
  @HiveField(1)
  friend,
}

const relationshipString = <Relationship, String>{
  Relationship.family: "Family",
  Relationship.friend: "Friend",
};

@HiveType(typeId: 0)
class Contact {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;
  @HiveField(2)
  final Relationship relationship;
  @HiveField(3)
  final String phoneNumber;
  Contact({
    required this.name,
    required this.age,
    required this.relationship,
    required this.phoneNumber,
  });
}
