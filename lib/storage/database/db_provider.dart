import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static final DbProvider _instance = DbProvider._internal();

  DbProvider._internal();

  late Database _database;

  factory DbProvider() {
    return _instance;
  }

  Database get database => _database;

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'cart_db.sql');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('CREATE TABLE cart ('
            'id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,'
            'product_id INT NOT NULL,'
            'product_name TEXT NOT NULL,'
            'product_image TEXT NOT NULL,'
            'user_id INT NOT NULL,'
            'quantity INT NOT NULL,'
            'price INT NOT NULL'
            ')');
      },
      onDowngrade: (db, oldVersion, newVersion) {},
    );
  }
}
