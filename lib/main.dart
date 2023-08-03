import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_hive_flutter/constants.dart';
import 'package:learn_hive_flutter/home_page.dart';

void main() async {
  //todo 1 inisialisasi (next home_page.dart)
  await Hive.initFlutter();
  await Hive.openBox<String>(favoritesBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
