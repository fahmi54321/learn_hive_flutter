// generate adapter

import 'package:hive/hive.dart';

//todo 1
part 'user.g.dart';

// todo 2
@HiveType(typeId: 0) // (between 0 and 223)
class User {
  @HiveField(0)
  String nama;

  @HiveField(1)
  int umur;
  User({
    required this.nama,
    required this.umur,
  });
}

// todo 3
// flutter packages pub run build_runner build
