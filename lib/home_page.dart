import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:learn_hive_flutter/hive_object_example.dart';
import 'package:learn_hive_flutter/value_listenable_example.dart';
import 'package:learn_hive_flutter/write_read_object_example.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    init();
  }

  init() async {
    // open box
    var box = await Hive.openBox('testBox');
    var lazyBox = await Hive.openLazyBox<String>('lazyBox');
    var writeNullBox = await Hive.openBox('writeNullBox');

    log('box is open : ${box.isOpen}');

    // write
    await box.put('key', 'name');
    await box.put('key2', ['nama1', 'nama2', 'nama3']);
    await box.put(123, 'number key');
    await box.putAll(
      {'key3': 'value3.1', 'key4': 'value.3.2'},
    );
    var future = lazyBox.put('keyFuture', 'value');
    writeNullBox.put('keyWriteNullBox', 'value');
    writeNullBox.put('keyWriteNullBox', null);
    // writeNullBox.delete('keyWriteNullBox');

    // read
    String name = box.get('key');
    log('name : $name');

    // read with default value
    String key1 = box.get('key', defaultValue: 'kosong');
    List<String> key2 = box.get('key2', defaultValue: 'kosong');
    String keyNumber = box.get(123, defaultValue: 'kosong');
    String key3 = box.get('key3', defaultValue: 'kosong');
    String key4 = box.get('key4', defaultValue: 'kosong');
    log('key1 : $key1');
    log('key2 : $key2');
    log('key3 : $key3');
    log('keyNumber : $keyNumber');
    log('key4 : $key4');

    log('keyFuture1 : ${lazyBox.get('keyFuture')}'); // null
    await future;
    log('keyFuture2 : ${lazyBox.get('keyFuture')}'); // not null

    // is put null = keyWriteNullBox : true
    // is delete = keyWriteNullBox : false
    log('keyWriteNullBox : ${writeNullBox.containsKey('keyWriteNullBox')}');

    // close
    // await box.close();

    log('box is open : ${box.isOpen}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive flutter'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ValueListenableExample(),
                ),
              );
            },
            child: Text(
              'Goto Next Learn',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          MaterialButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WriteAndReadObjectExample(),
                ),
              );
            },
            child: Text(
              'Goto Next Learn Type Adapter',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          MaterialButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HiveObjectExample(),
                ),
              );
            },
            child: Text(
              'Goto Next Learn Hive Object',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
