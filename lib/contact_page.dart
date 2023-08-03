import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_hive_flutter/add_contact_page.dart';
import 'package:learn_hive_flutter/constants.dart';
import 'package:learn_hive_flutter/models/contacts.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts App with Hive'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Contact>(contactsBoxName).listenable(),
        builder: (context, Box<Contact> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text("No contacts"),
            );
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              Contact? currentContact = box.getAt(index);
              String? relationship =
                  relationshipString[currentContact?.relationship];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(
                            "Do you want to delete ${currentContact?.name}?",
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text("No"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            ElevatedButton(
                              child: const Text("Yes"),
                              onPressed: () async {
                                await box.deleteAt(index);
                                WidgetsBinding.instance
                                    .addPostFrameCallback((timeStamp) {
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 5),
                        Text(currentContact?.name ?? '-'),
                        const SizedBox(height: 5),
                        Text(currentContact?.phoneNumber ?? '-'),
                        const SizedBox(height: 5),
                        Text("Age: ${currentContact?.age}"),
                        const SizedBox(height: 5),
                        Text("Relationship: $relationship"),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddContact(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
