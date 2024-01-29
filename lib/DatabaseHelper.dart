import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'User.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;
  static final table = 'user_table';
  static final columnId = 'id';
  static final columnName = 'name';
  static final columnEmail = 'email';

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only have a single app-wide reference to the database.
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return database;
    _database = await _initDatabase();
    return database;
  }

  // Open the database and create it if it doesn't exist.
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnEmail TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database.
  Future<int> insert(User user) async {
    Database db = await database;
    return await db.insert(table, user.toMap());
  }


  // All of the rows are returned as a list of maps, each map is a key-value list of columns.
  Future<List<User>> queryAllRows() async {
    Database db = await database;
    var res = await db.query(table);
    List<User> list =
    res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : [];
    return list;
  }

  // We are assuming here that the id column in the map is set. The other column values will be used to update the row.
  Future<int> update(User user) async {
    Database db = await database;
    int id = user.toMap()['id'];
    return await db.update(table, user.toMap(), where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is returned.
  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
