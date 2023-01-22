import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 1)
class Person extends HiveObject {
  @HiveField(0)
  String nama;
  Person({
    required this.nama,
  });
}
