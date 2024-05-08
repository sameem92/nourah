import 'package:producer_family_app/storage/database/db_operations.dart';
import 'package:producer_family_app/storage/database/db_provider.dart';
import 'package:producer_family_app/storage/models/cart.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:sqflite/sqflite.dart';

class CartDbController implements DbOperations<Cart> {
    Database _database = DbProvider().database;
  CartDbController():_database=DbProvider().database;
  @override
  Future<int> create(Cart object) async {
    return await _database.insert('cart', object.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    int countOfDeletedRows =
        await _database.delete('cart', where: 'id = ?', whereArgs: [id]);
    return countOfDeletedRows > 0;
  }

  Future<bool> cleanCart() async {
    int countOfDeletedRows = await _database.delete('cart');
    return countOfDeletedRows > 0;
  }

  @override
  Future<List<Cart>> read() async {
    List<Map<String, dynamic>> rowsMap = await _database.query('cart',
        where: 'user_id = ?',
        whereArgs: [SharedPreferencesController().getUserId()]);
    return rowsMap.map((e) => Cart.fromMap(e)).toList();
  }

  @override
  Future<bool> update(Cart object) async {
    int countOfDeletedRows = await _database.update('cart', object.toMap(),
        where: 'id = ?', whereArgs: [object.id]);
    return countOfDeletedRows > 0;
  }
}
