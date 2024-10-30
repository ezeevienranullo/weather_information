import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../model/note_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
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
    CREATE TABLE notes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT NOT NULL,
      content TEXT NOT NULL
    )
    ''');
  }

  // Insert a new note
  Future<void> insertNote(Note note) async {
    final db = await instance.database;
    await db.insert('notes', note.toMap());
  }

  // Retrieve notes by date
  Future<List<Note>> getNotesByDate(String date) async {
    final db = await instance.database;
    final maps = await db.query(
      'notes',
      where: 'date = ?',
      whereArgs: [date],
    );

    return List.generate(maps.length, (i) => Note.fromMap(maps[i]));
  }

  // Close the database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}


