import 'package:fpdart/fpdart.dart';
import 'package:vitalinguu/core/base/id_base.dart';
import 'package:vitalinguu/core/storage/hive_storage.dart';
import 'package:vitalinguu/core/storage/storage_interface.dart';

Future<StorageInterface<T>> getStorage<T extends IdBase>({Option <String> boxName = const None()}) async{
  StorageInterface<T> storage = HiveStorage<T>(name: boxName);
  await storage.initDB();
  return storage;
}