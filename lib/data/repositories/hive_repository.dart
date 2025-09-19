import 'package:hive_ce/hive.dart';

class HiveRepository<T extends HiveObject> {
  final String boxName;

  HiveRepository(this.boxName);

  Future<Box<T>> _getBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    }
    return Hive.box<T>(boxName);
  }

  Future<void> add(T item, {dynamic key}) async {
    final box = await _getBox();
    if (key != null) {
      await box.put(key, item);
    } else {
      await box.add(item);
    }
  }

  Future<T?> get(dynamic key) async {
    final box = await _getBox();
    return box.get(key);
  }

  Future<List<T>> getAll() async {
    final box = await _getBox();
    return box.values.toList();
  }

  Future<void> update(T item) async {
    if (!item.isInBox) {
      throw Exception("Object is not in the box");
    }
    await item.save();
  }

  Future<void> delete(dynamic key) async {
    final box = await _getBox();
    await box.delete(key);
  }

  Future<void> deleteAll() async {
    final box = await _getBox();
    await box.clear();
  }

  Future<int> get length async {
    final box = await _getBox();
    return box.length;
  }
}