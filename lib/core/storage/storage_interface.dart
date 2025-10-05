import 'package:fpdart/fpdart.dart';
import 'package:vitalinguu/core/base/id_base.dart';

abstract class StorageInterface<T extends IdBase> {
  Future<void> initDB();
  Future<void> closeDB();
  Future<void> deleteAll();
  Future<Option<T>> getById(String id);
  Option<T> getByIdSync(String id);

  Future<List<T>> getAll();
  Future<void> save(T item);
  Future<void> delete(T item);
  Future<void> update(T item);
  Future<int> count();
}