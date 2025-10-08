import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitalinguu/core/navigation/app_router.dart';

part 'navigation_providers.g.dart';


@Riverpod(keepAlive: true)
AppRouter appRouter(AppRouterRef ref) {
  return AppRouter();
}

