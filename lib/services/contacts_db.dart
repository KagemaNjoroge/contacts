import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contacts.dart';

class ContactDatabaseService {
  String createContactsTableQuery = '''

                                        CREATE TABLE contacts(
                                          id INTEGER PRIMARY KEY AUTOINCREMENT,
                                          firstName TEXT NOT NULL,
                                          lastName TEXT,
                                          company TEXT,
                                          email TEXT,
                                          phone TEXT NOT NULL UNIQUE,
                                          website TEXT,
                                          address TEXT,
                                          notes TEXT,
                                          photoUrl TEXT
                                        )
                                  ''';
  Future<Database> initializeDatabase() async {
    return openDatabase(join(await getDatabasesPath(), 'contacts.db'),
        onCreate: (database, version) async {
      await database.execute(createContactsTableQuery);
    }, version: 1);
  }

  Future<void> insertContact(Contact contact) async {
    final Database db = await initializeDatabase();
    await db.insert(
      'contacts',
      contact.toJsonDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Contact>> retrieveAllContacts() async {
    final Database db = await initializeDatabase();
    final List<Map<String, Object?>> queryResult = await db.query('contacts');
    return queryResult.map((e) => Contact.fromJson(e)).toList();
  }

  Future<void> updateContact(Contact contact) async {
    final Database db = await initializeDatabase();
    await db.update(
      'contacts',
      contact.toJson(),
      where: 'phone = ?',
      whereArgs: [contact.phone],
    );
  }

  Future<void> deleteContact(String phone) async {
    final Database db = await initializeDatabase();
    await db.delete(
      'contacts',
      where: 'phone = ?',
      whereArgs: [phone],
    );
  }
}
