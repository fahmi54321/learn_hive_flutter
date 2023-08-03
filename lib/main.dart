import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_hive_flutter/constants.dart';
import 'package:learn_hive_flutter/draw_page.dart';
import 'package:learn_hive_flutter/models/color_path.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ColoredPathAdapter());
  await Hive.openBox<ColoredPath>(sketchBox);

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
      home: const DrawingScreen(),
    );
  }
}
