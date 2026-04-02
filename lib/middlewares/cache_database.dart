// import 'dart:ui';
// import 'package:path/path.dart' as p;
// import 'package:sqflite/sqflite.dart';

// class CacheDatabase {
//   static Database? _db;

//   static Future<Database> get instance async {
//     if (_db != null) return _db!;
//     _db = await _initDb();
//     return _db!;
//   }

//   static Future<Database> _initDb() async {
//     final dbPath = await getDatabasesPath();
//     final path = p.join(dbPath, 'cache.db');

//     return openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute(
//           '''
//             CREATE TABLE cache (
//               key TEXT PRIMARY KEY,
//               timestamp TEXT,
//               data TEXT
//             )
//           '''
//         );
//       },
//     );
//   }
// }