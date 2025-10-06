import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:vitalinguu/core/navigation/app_router.dart';
import 'package:vitalinguu/core/navigation/app_router.gr.dart';

@injectable
class NavigationService {
  final AppRouter _router;

  NavigationService(this._router);

  StackRouter get router => _router;

  Future<void> replaceWithLanguageSelection() async {
    await _router.replace(LanguageSelectionRoute());
  }
}
