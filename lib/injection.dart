import 'package:appmable_desktop/domain/services/navigator_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
GetIt configureDependencies() {
  final getIt = $initGetIt(GetIt.instance);
  return getIt;
}

@module
abstract class RegisterModule {

  // Connectivity Library
  Connectivity get connectivity => Connectivity();

  // Core Singletons
  NavigatorService get navigatorService => NavigatorService.instance;
}
