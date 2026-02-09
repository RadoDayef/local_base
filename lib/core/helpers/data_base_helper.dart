import 'package:local_base/features/home/data/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  /// Database
  static Database? _database;

  /// Instance
  static final DataBaseHelper instance = DataBaseHelper._();

  /// Private Constructor
  DataBaseHelper._();

  /// Check DataBase
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDataBase();
    return _database!;
  }

  /// Init DB
  Future<Database> _initDataBase() async {
    String path = await getDatabasesPath();
    String fullPath = join(path, "users.db");

    return await openDatabase(fullPath, version: 1, onCreate: _createDataBase);
  }

  /// Create DB
  Future<void> _createDataBase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        gender TEXT NOT NULL,
        age INTEGER NOT NULL,
        lastName TEXT NOT NULL,
        firstName TEXT NOT NULL,
        id TEXT PRIMARY KEY
      )
    ''');
  }

  /// Create User
  Future<int> createUser(User user) async {
    Database db = await database;
    return await db.insert("users", user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Read Users
  Future<List<User>> readUsers() async {
    Database db = await database;
    List<Map<String, dynamic>> usersAsMap = await db.query("users");
    List<User> users = usersAsMap.map((Map<String, dynamic> user) => User.fromMap(user)).toList();

    return users;
  }

  /// Update User
  Future<int> updateUser(User user) async {
    try{
      print(user.id);
      Database db = await database;
      return await db.update("users", user.toMap(), where: "id = ?", whereArgs: [user.id]);
    }catch(e, s){
      print(e);
      print(s);
      return 0;
    }
  }

  /// Delete User
  Future<int> deleteUser(String id) async {
    Database db = await database;
    return await db.delete("users", where: "id = ?", whereArgs: [id]);
  }

  /// Clear
  Future<void> clearUsers() async {
    Database db = await database;
    await db.delete("users");
  }

  /// Drop
  Future<void> dropDatabase() async {
    String path = await getDatabasesPath();
    String fullPath = join(path, "users.db");
    await deleteDatabase(fullPath);
  }
}
