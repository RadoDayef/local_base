import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  /// Database
  static Database? _database;

  /// Instance
  static final DataBaseHelper instance = DataBaseHelper._init();

  /// Private Constructor
  DataBaseHelper._init();

  /// Check DataBase
  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initDataBase();
    return _database!;
  }

  /// Init DB
  Future<Database> _initDataBase() async {
    String path = await getDatabasesPath();
    String fullPath = join(path, "users.db");

    return await openDatabase(fullPath);
  }

  /// Create DB
  Future<void> _createDataBase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id TEXT PRIMARY KEY,
        gender TEXT NOT NULL,
        age INTEGER NOT NULL,
        lastName TEXT NOT NULL,
        firstName TEXT NOT NULL
      )
    ''');
  }

/// Create User
/// Read Users
/// Update User
/// Delete User
/// Clear
}
