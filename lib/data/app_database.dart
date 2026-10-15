import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final instance = AppDatabase._();
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    final path = join(await getDatabasesPath(), 'liferise.db');
    _db = await openDatabase(path, version: 1, onCreate: (db, _) async {
      await db.execute('''CREATE TABLE daily_logs(id TEXT PRIMARY KEY, day TEXT NOT NULL, type TEXT NOT NULL, payload TEXT NOT NULL, created_at TEXT NOT NULL)''');
      await db.execute('''CREATE TABLE journal_entries(id TEXT PRIMARY KEY, day TEXT NOT NULL, mood TEXT, note TEXT, created_at TEXT NOT NULL)''');
      await db.execute('''CREATE TABLE reading_sessions(id TEXT PRIMARY KEY, day TEXT NOT NULL, minutes INTEGER NOT NULL, pages INTEGER NOT NULL, created_at TEXT NOT NULL)''');
    });
    return _db!;
  }
}
