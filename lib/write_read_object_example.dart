import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learn_hive_flutter/models/user.dart';

class WriteAndReadObjectExample extends StatefulWidget {
  const WriteAndReadObjectExample({super.key});

  @override
  State<WriteAndReadObjectExample> createState() =>
      _WriteAndReadObjectExampleState();
}

class _WriteAndReadObjectExampleState extends State<WriteAndReadObjectExample> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    Hive.registerAdapter(UserAdapter()); // wajib inisialisasi di main.dart
    var box = await Hive.openBox<User>('userBox');

    box.put(
      'fahmi',
      User(nama: 'Fahmi', umur: 23),
    );
    box.put(
      'abdul',
      User(nama: 'Abdul', umur: 22),
    );

    log('user : ${box.values}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Object'),
      ),
      body: Container(),
    );
  }
}
