// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/bloc/login_screen/login_screen_bloc.dart' as _i17;
import 'application/bloc/main_screen/main_screen_bloc.dart' as _i9;
import 'domain/repositories/user_repository.dart' as _i14;
import 'domain/services/connectivity_checker_service.dart' as _i4;
import 'domain/services/http_service.dart' as _i6;
import 'domain/services/navigator_service.dart' as _i10;
import 'domain/services/start_up_router_service.dart' as _i12;
import 'domain/services/start_up_service.dart' as _i13;
import 'domain/services/storage/local_storage_service.dart' as _i8;
import 'domain/services/storage/session_storage_service.dart' as _i11;
import 'domain/services/user_service.dart' as _i16;
import 'infrastructure/repositories/user/http_user_repository.dart' as _i15;
import 'infrastructure/services/flutter_connectivity_checker_service.dart'
    as _i5;
import 'infrastructure/services/http_service.dart' as _i7;
import 'injection.dart' as _i18; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.factory<_i3.Connectivity>(() => registerModule.connectivity);
  gh.factory<_i4.ConnectivityCheckerService>(
      () => _i5.FlutterConnectivityCheckerService(get<_i3.Connectivity>()));
  gh.factory<_i6.HttpService>(() => _i7.FlutterHttpService());
  gh.factory<_i8.LocalStorageService>(() => registerModule.localStorageService);
  gh.lazySingleton<_i9.MainScreenBloc>(() => _i9.MainScreenBloc());
  gh.factory<_i10.NavigatorService>(() => registerModule.navigatorService);
  gh.factory<_i11.SessionStorageService>(
      () => _i11.SessionStorageService(get<_i8.LocalStorageService>()));
  gh.factory<_i12.StartUpRouterService>(
      () => _i12.StartUpRouterService(get<_i8.LocalStorageService>()));
  gh.factory<_i13.StartUpService>(() => _i13.StartUpService(
        get<_i12.StartUpRouterService>(),
        get<_i8.LocalStorageService>(),
      ));
  gh.factory<_i14.UserRepository>(
      () => _i15.HttpButtonRepository(get<_i6.HttpService>()));
  gh.factory<_i16.UserService>(
      () => _i16.UserService(get<_i14.UserRepository>()));
  gh.lazySingleton<_i17.LoginScreenBloc>(() => _i17.LoginScreenBloc(
        get<_i16.UserService>(),
        get<_i8.LocalStorageService>(),
      ));
  return get;
}

class _$RegisterModule extends _i18.RegisterModule {}
