import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ValueListenableExample extends StatefulWidget {
  const ValueListenableExample({super.key});

  @override
  State<ValueListenableExample> createState() => _ValueListenableExampleState();
}

class _ValueListenableExampleState extends State<ValueListenableExample> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setState(() {
      isLoading = true;
    });
    await Hive.openBox('settings');

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ValueListenableBuilder<Box>(
              valueListenable: Hive.box('settings').listenable(),
              // valueListenable: Hive.box('settings').listenable(keys: ['firstKey', 'secondKey']), // Listening for specific keys
              builder: (context, box, widget) {
                return Center(
                  child: Switch(
                    value: box.get('darkMode', defaultValue: false),
                    onChanged: (val) {
                      box.put('darkMode', val);
                    },
                  ),
                );
              },
            ),
    );
  }
}
