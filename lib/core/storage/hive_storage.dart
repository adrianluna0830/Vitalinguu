import 'package:fpdart/fpdart.dart';
import 'package:hive_ce/hive.dart';
import 'package:vitalinguu/core/base/id_base.dart';
import 'package:vitalinguu/core/storage/storage_interface.dart';

class HiveStorage<T extends IdBase> implements StorageInterface<T>
{
  Box<T> box;
  HiveStorage({Option<String> name = const None()}) : box = Hive.box<T>(name.getOrElse(() => '${T}_box'));
  @override
  Future<void> initDB() async{
    if (!Hive.isBoxOpen(box.name)) {
      await Hive.openBox<T>(box.name);
    }
  }

  @override
  Future<void> closeDB() {
    return box.close();
  }

  @override
  Future<void> deleteAll() {
    return box.clear();
  }

  @override
  Future<Option<T>> getById(String id) {
    final item = box.get(id);
    return Future.value(item != null ? Option.of(item) : Option.none());
  }

  @override
  Future<List<T>> getAll() async {
    return Future.value(box.values.toList());
  }

  @override
  Future<void> save(T item) async {
    return box.put(item.id, item);
  }

  @override
  Future<void> delete(T item) {
    return box.delete(item.id);
  }

  @override
  Future<void> update(T item) {
    return box.put(item.id, item);
  }
}