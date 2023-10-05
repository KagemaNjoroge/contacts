import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class IdeaPage extends StatefulWidget {
  const IdeaPage({super.key});

  @override
  State<IdeaPage> createState() => _IdeaPageState();
}

class _IdeaPageState extends State<IdeaPage> {
  void write() async {
    var paths = await getDatabasesPath();
    File txtFile = File('$paths/hello.txt');
    var data = await txtFile.readAsString();

    var vars = Platform.localeName;
    print(vars);
  }

  final DateTime _selectedTime = DateTime.now();
  final DateTime _firstDate = DateTime(2023, 9, 17);
  final DateTime _LastDate = DateTime(2023, 10, 30);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date time Picker'),
      ),
      body: Center(
        child: IconButton(
            onPressed: () {
              write();
            },
            icon: const Icon(Icons.error)),
      ),
    );
  }
}
