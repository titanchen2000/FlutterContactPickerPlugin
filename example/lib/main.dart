import 'package:flutter/material.dart';

import 'package:free_contact_picker/contact_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _contactPickerPlugin = ContactPicker();
  String _contactName = '';
  String _contactPhone = '';

  void pickContact() {
    _contactPickerPlugin.pickContact(
      (contact) {
        setState(() {
          _contactName = contact['name'];
          _contactPhone = contact['phone'];
        });
      },
      onError: (error) {
        debugPrint(error);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('ContactName: $_contactName'),
              Text('ContactPhone: $_contactPhone'),
              FilledButton(onPressed: pickContact, child: Text('Pick Contact')),
            ],
          ),
        ),
      ),
    );
  }
}
