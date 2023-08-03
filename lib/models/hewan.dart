// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'hewan.g.dart';

@HiveType(typeId: 1)
class Hewan extends HiveObject {
  @HiveField(0)
  final String kategori;

  @HiveField(1)
  HiveList<HewanList> hewans;

  Hewan({
    required this.kategori,
    required this.hewans,
  });
}

@HiveType(typeId: 2)
class HewanList extends HiveObject {
  @HiveField(0)
  final String nama;
  HewanList({
    required this.nama,
  });
}
