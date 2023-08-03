import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:learn_hive_flutter/models/hewan.dart';

class HiveListExample extends StatefulWidget {
  const HiveListExample({super.key});

  @override
  State<HiveListExample> createState() => _HiveListExampleState();
}

class _HiveListExampleState extends State<HiveListExample> {
  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    // Hive.registerAdapter(HewanAdapter()); // inisialisasi ketika di main.dart
    // Hive.registerAdapter(
    //     HewanListAdapter()); // inisialisasi ketika di main.dart
    var hewan = await Hive.openBox<Hewan>('hewan');
    var herbivoras = await Hive.openBox<HewanList>('herbivoras');
    var karnivoras = await Hive.openBox<HewanList>('karnivoras');

    final herbivoraObject = Hewan(
      kategori: 'herbivoraObject',
      hewans: HiveList(herbivoras),
    );

    final karnivoraObject = Hewan(
      kategori: 'karnivoraObject',
      hewans: HiveList(karnivoras),
    );

    // hewan.addAll([herbivoraObject, karnivoraObject]);
    // herbivoraObject.save();
    // karnivoraObject.save();

    // hewan.clear();
    // karnivoras.clear();
    // herbivoras.clear();

    for (var item in herbivoras.values.toList()) {
      debugPrint('heii hewan : ${item.nama}');
    }

    for (var item in hewan.values.toList()) {
      debugPrint('jenis hewan : ${item.kategori}');
      debugPrint('list hewan : ${item.hewans}');
      for (var items in item.hewans) {
        debugPrint('nama hewan : ${items.nama}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
