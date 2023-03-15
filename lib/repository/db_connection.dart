import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {

  initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_casual_demo');
    var database = await openDatabase(
        path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }


  _onCreatingDatabase(Database db, int Version) async {
    await db.execute('CREATE TABLE job(id INTEGER PRIMARY KEY,jobId INTEGER,jobName TEXT,jobAmount INTEGER,jobQuantity INTEGER)');
  }

}