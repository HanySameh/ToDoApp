import 'package:sqflite/sqflite.dart';
import 'package:to_do/models/task.dart';

class DBHelper {
  static Database? db;

  static Future<void> initDb() async {
    if (db == null) {
      // String path = await getDatabasesPath() + 'Todo.db';
      db = await openDatabase(
        'Todo.db',
        version: 1,
        onCreate: (Database db, int version) async {
          print('database created');
          await db
              .execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT,title STRING,note TEXT,date STRING,startTime STRING,endTime STRING,remind INTEGER,repeat STRING,color INTEGER,isCompleted INTEGER,category STRING)',
          )
              .then((value) {
            print('table created');
          }).catchError((error) {
            print(error.toString());
          });
        },
      );
    } else {
      print('database');
    }
  }

  static Future insertToDb(Task? task) async {
    return await db!
        .insert(
      'tasks',
      task!.toJson(),
    )
        .then((value) {
      print('$value inserted successful');
    }).catchError((error) {
      print(error.toString());
    });
  }

  static Future delete(Task? task) async {
    try {
      return await db!.delete('tasks', where: 'id=?', whereArgs: [task!.id]);
    } catch (error) {
      print(error.toString());
    }
  }

  static Future deleteAll() async {
    try {
      return await db!.delete(
        'tasks',
      );
    } catch (error) {
      print(error.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('query');
    return await db!.query(
      'tasks',
    );
  }

  static Future updateDb(int id) async {
    return await db!.rawUpdate(
        'UPDATE tasks SET isCompleted = ? WHERE id = ?', [1, id]).then((value) {
      print('task updeted successful');
    }).catchError((error) {
      print(error.toString());
    });
  }

  static Future updatetask(Task task) async {
    return await db!
        .update('tasks', task.toJson(), where: 'id=?', whereArgs: [task.id]);
  }
}
