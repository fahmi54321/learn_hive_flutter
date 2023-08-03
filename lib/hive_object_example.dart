import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learn_hive_flutter/models/person.dart';

class HiveObjectExample extends StatefulWidget {
  const HiveObjectExample({super.key});

  @override
  State<HiveObjectExample> createState() => _HiveObjectExampleState();
}

class _HiveObjectExampleState extends State<HiveObjectExample> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    // Hive.registerAdapter(PersonAdapter()); // wajib inisialisasi di main.dart
    // var persons = await Hive.openBox<Person>('persons');

    // persons.add(Person(nama: 'Abdul')); // default key nya auto increment
    // persons.put('someKey', Person(nama: 'Aziz')); // key nya bisa custom
    // persons.delete(1);
    // persons.clear();
    // debugPrint('person keyAt : ${persons.keyAt(0)}');
    // debugPrint('person valueAt : ${persons.getAt(0)?.nama}');

    // for (var data in persons.values.toList()) {
    //   debugPrint('person key : ${data.key}, person name : ${data.nama}');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive object'),
      ),
    );
  }
}
