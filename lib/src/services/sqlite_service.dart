// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// class SQLiteService {
//   static Database? _database;
//
//   // Initialize the SQLite database
//   Future<void> initDB() async {
//     String path = join(await getDatabasesPath(), 'biomark.db');
//     _database = await openDatabase(
//       path,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE volunteers (
//             id TEXT PRIMARY KEY,
//             fullName TEXT,
//             email TEXT,
//             dateOfBirth TEXT,
//             bloodGroup TEXT,
//             sex TEXT,
//             height REAL,
//             ethnicity TEXT,
//             eyeColor TEXT
//           )
//         ''');
//       },
//       version: 1,
//     );
//   }
//
//   // Save volunteer data locally
//   Future<void> saveVolunteerData(Map<String, dynamic> volunteerData) async {
//     await _database?.insert('volunteers', volunteerData, conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   // Get volunteer data locally
//   Future<Map<String, dynamic>?> getVolunteerData(String uid) async {
//     List<Map<String, dynamic>> result = await _database?.query(
//       'volunteers',
//       where: 'id = ?',
//       whereArgs: [uid],
//     ) ?? [];
//     return result.isNotEmpty ? result.first : null;
//   }
//
//   // Delete local volunteer data
//   Future<void> deleteVolunteerData(String uid) async {
//     await _database?.delete('volunteers', where: 'id = ?', whereArgs: [uid]);
//   }
// }
