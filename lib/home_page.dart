import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_hive_flutter/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //todo 2
  late Box<String> favoriteBooksBox;

  //todo 3
  @override
  void initState() {
    super.initState();
    favoriteBooksBox = Hive.box(favoritesBox);
  }

  //todo 4
  void onFavoritePress(int index) {
    if (favoriteBooksBox.containsKey(index)) {
      favoriteBooksBox.delete(index);
      return;
    }
    favoriteBooksBox.put(index, books[index]);
  }

  // todo 5
  void onClearPress() {
    favoriteBooksBox.clear();
  }

  // todo 6
  Widget getIcon(int index) {
    if (favoriteBooksBox.containsKey(index)) {
      return const Icon(
        Icons.favorite,
        color: Colors.red,
      );
    }

    return const Icon(Icons.favorite_border);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Books'),
        actions: [
          TextButton(
            onPressed: onClearPress,
            child: Row(
              children: const [
                Text(
                  'Clear',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 10.0),
                Icon(Icons.clear, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
      //todo 7 (finish)
      body: ValueListenableBuilder(
        valueListenable: favoriteBooksBox.listenable(),
        builder: (BuildContext context, Box<String> box, _) {
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(books[index]),
                trailing: IconButton(
                  onPressed: () => onFavoritePress(index),
                  icon: getIcon(index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
