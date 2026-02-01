import 'package:idb_shim/idb.dart';
import 'package:idb_shim/idb_browser.dart';

class FavoritesDB {
  static const dbName = 'favorites_db';
  static const storeName = 'favorites';
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await idbFactoryBrowser!.open(
      dbName,
      version: 1,
      onUpgradeNeeded: (e) {
        e.database.createObjectStore(storeName, keyPath: 'id');
      },
    );
    return _db!;
  }

  static Future<Set<int>> getFavorites() async {
    final db = await database;
    final tx = db.transaction(storeName, 'readonly');
    final store = tx.objectStore(storeName);
    final keys = await store.getAllKeys();
    await tx.completed;
    return keys.cast<int>().toSet();
  }

  static Future<void> add(int id) async {
    final db = await database;
    final tx = db.transaction(storeName, 'readwrite');
    await tx.objectStore(storeName).put({'id': id});
    await tx.completed;
  }

  static Future<void> remove(int id) async {
    final db = await database;
    final tx = db.transaction(storeName, 'readwrite');
    await tx.objectStore(storeName).delete(id);
    await tx.completed;
  }
}
