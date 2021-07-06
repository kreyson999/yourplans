import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yourplans/models/category.dart';
import 'package:yourplans/models/task.dart';

class SqfLiteService {

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "TodoApp.db"),
      version: 1,
      onCreate: (database, version) async {
        await database.execute(
          """
          CREATE TABLE TodoTable(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          category TEXT NOT NULL,
          taskColor TEXT NOT NULL,
          iconData TEXT NOT NULL
          )
          """
        );
        await database.execute(
            """
          CREATE TABLE CategoryTable(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          categoryName TEXT NOT NULL,
          categoryColor TEXT NOT NULL,
          iconData TEXT NOT NULL
          )
          """
        );
      }
    );
  }

  Future<bool> insertData(TaskModel taskModel) async {
    final Database db = await initDatabase();
    db.insert("TodoTable", taskModel.toMap());
    return true;
  }

  Future<List<TaskModel>> getData() async {
    final Database db = await initDatabase();
    final List<Map<String, Object?>> taskData = await db.query("TodoTable");
    return taskData.map((e) => TaskModel.fromMap(e)).toList();
  }

  Future<void> update(TaskModel taskModel) async {
    final Database db = await initDatabase();
    await db.update("TodoTable", taskModel.toMap(), where: "id=?", whereArgs: [taskModel.id]);
  }
  Future<void> delete(int index) async {
    final Database db = await initDatabase();
    await db.delete("TodoTable", where: "id=?", whereArgs: [index]);
  }

  /// category
  Future<bool> insertCategory(CategoryModel categoryModel) async {
    final Database db = await initDatabase();
    db.insert("CategoryTable", categoryModel.toMap());
    return true;
  }
  Future<List<CategoryModel>> getCategory() async {
    final Database db = await initDatabase();
    final List<Map<String, Object?>> categoryData = await db.query("CategoryTable");
    return categoryData.map((e) => CategoryModel.fromMap(e)).toList();
  }
}