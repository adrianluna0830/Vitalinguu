import 'package:fpdart/fpdart.dart';
import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:vitalinguu/core/base/id_base.dart';
import 'package:vitalinguu/core/storage/storage_interface.dart';

class HiveStorage<T extends IdBase> implements StorageInterface<T>
{
  late HivezBox<String, T> box;
  late final String boxName;

  HiveStorage({Option<String> name = const None()}) {
    boxName = name.getOrElse(() => '${T}_box');
  }
  @override
  Future<void> initDB() async{
    box = HivezBox<String, T>(boxName);
    await box.ensureInitialized();
  }

  @override
  Future<void> closeDB() async {
    await box.closeBox();
  }

  @override
  Future<void> deleteAll() async {
    await box.clear();
  }

  @override
  Future<Option<T>> getById(String id) async {
    final item = await box.get(id);
    return item != null ? Option.of(item) : Option.none();
  }

  @override
  Future<List<T>> getAll() async {
    final values = await box.getAllValues();
    return values.toList();
  }

  @override
  Future<void> save(T item) async {
    await box.put(item.id, item);
  }

  @override
  Future<void> delete(T item) async {
    await box.delete(item.id);
  }

  @override
  Future<void> update(T item) async {
    await box.put(item.id, item);
  }
  
  @override
  Option<T> getByIdSync(String id) {
    // Hivez es completamente async, esta función necesitará ser async también
    // Por ahora retornamos None() ya que no hay soporte síncrono en Hivez
    return Option.none();
  }
  
  @override
  Future<int> count() async {
    return await box.length;
  }
}