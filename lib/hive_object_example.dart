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
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async {
    Hive.registerAdapter(PersonAdapter());
    var persons = await Hive.openBox<Person>('persons');

    // Store this object for the first time
    var person = Person(nama: 'Fahmi');

    // persons.add(person);

    log('Number of persons: ${persons.values.toList()}');
    log("Lisa's first key: ${person.key}");

    // person.nama = 'Lucas';
    // person.save(); // Update object

    // log('Number of persons after update: ${persons.length}');
    // log("Person first key: ${person.key}");
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
