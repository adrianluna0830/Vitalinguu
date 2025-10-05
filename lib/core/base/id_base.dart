import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

final Uuid _uuid = Uuid();

abstract class IdBase<T> {
  final String id;

  IdBase({Option<T> id = const None()}) : id = id.map((value) => value.toString()).getOrElse(() => _uuid.v4());
}
