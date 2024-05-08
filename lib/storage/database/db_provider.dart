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
      onOpen: (Database db){},
      onCreate: (Database db,int version) async{

       await db.execute('CREATE TABLE cart ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'product_id INT NOT NULL,'
            'product_name TEXT NOT NULL,'
            'product_image TEXT NOT NULL,'
            'user_id INT NOT NULL,'
            'qty INT NOT NULL,'
            'total INT NOT NULL,'
            'offer_status INT NOT NULL,'
            'intial_price INT NOT NULL'
            ')');
      },
      onUpgrade: (Database db,int oldVersion,int newVersion) {},

      onDowngrade: (Database db,int oldVersion,int newVersion) {},
    );
  }
}
