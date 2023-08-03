import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:learn_hive_flutter/constants.dart';
import 'package:learn_hive_flutter/models/contacts.dart';

class AddContact extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  AddContact({super.key});

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  String name = '';
  int age = 0;
  String phoneNumber = '';
  Relationship relationship = Relationship.family;

  void onFormSubmit() {
    Box<Contact> contactsBox = Hive.box<Contact>(contactsBoxName);
    contactsBox.add(
      Contact(
        name: name,
        age: age,
        phoneNumber: phoneNumber,
        relationship: relationship,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: widget.formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    initialValue: "",
                    decoration: const InputDecoration(
                      labelText: "Name",
                    ),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: "",
                    maxLength: 3,
                    // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    maxLengthEnforcement:
                        MaxLengthEnforcement.truncateAfterCompositionEnds,
                    decoration: const InputDecoration(
                      labelText: "Age",
                    ),
                    onChanged: (value) {
                      setState(() {
                        age = int.parse(value);
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    initialValue: "",
                    decoration: const InputDecoration(
                      labelText: "Phone",
                    ),
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = value;
                      });
                    },
                  ),
                  DropdownButton<Relationship>(
                    items: relationshipString.keys.map((Relationship value) {
                      return DropdownMenuItem<Relationship>(
                        value: value,
                        child: Text(relationshipString[value] ?? "-"),
                      );
                    }).toList(),
                    value: relationship,
                    hint: const Text("Relationship"),
                    onChanged: (value) {
                      setState(() {
                        relationship = value ?? Relationship.family;
                      });
                    },
                  ),
                  OutlinedButton(
                    onPressed: onFormSubmit,
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
