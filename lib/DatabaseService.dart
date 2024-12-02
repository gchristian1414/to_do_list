
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();

  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        subtitle TEXT,
        time TEXT,
        isDon INTEGER NOT NULL
      )
    ''');
  }

  Future<int> addTask(String title, String subtitle, String time) async {
    final db = await instance.database;
    return await db.insert('tasks', {
      
      'title': title,
      'subtitle': subtitle,
      'time': time,
      'isDon': 0,
    });
  }

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    final db = await instance.database;
    return await db.query('tasks',
    );
  }
  

  Future<int> updateTask(int id, int isDon) async {
    final db = await instance.database;
    return await db.update(
      'tasks',
      {'isDon': isDon},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<int> updateTaskDetails(int id, String title, String subtitle, String time) async {
  final db = await instance.database;

  return await db.update(
    'tasks',
    {
      'title': title,
      'subtitle': subtitle,
      'time': time,
    },
    where: 'id = ?',
    whereArgs: [id],
  );
}

  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
