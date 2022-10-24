// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/bloc/dashboard_screen/dashboard_screen_bloc.dart' as _i20;
import 'application/bloc/login_screen/login_screen_bloc.dart' as _i21;
import 'application/bloc/users/users_screen/users_screen_bloc.dart' as _i19;
import 'domain/repositories/user_login_repository.dart' as _i13;
import 'domain/repositories/user_repository.dart' as _i16;
import 'domain/services/connectivity_checker_service.dart' as _i4;
import 'domain/services/http_service.dart' as _i6;
import 'domain/services/navigator_service.dart' as _i9;
import 'domain/services/start_up_router_service.dart' as _i11;
import 'domain/services/start_up_service.dart' as _i12;
import 'domain/services/storage/local_storage_service.dart' as _i8;
import 'domain/services/storage/session_storage_service.dart' as _i10;
import 'domain/services/user_login_service.dart' as _i15;
import 'domain/services/user_service.dart' as _i18;
import 'infrastructure/repositories/user/http_user_repository.dart' as _i17;
import 'infrastructure/repositories/userLogin/http_user_login_repository.dart'
    as _i14;
import 'infrastructure/services/flutter_connectivity_checker_service.dart'
    as _i5;
import 'infrastructure/services/http_service.dart' as _i7;
import 'injection.dart' as _i22; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i9.NavigatorService>(() => registerModule.navigatorService);
  gh.factory<_i10.SessionStorageService>(
      () => _i10.SessionStorageService(get<_i8.LocalStorageService>()));
  gh.factory<_i11.StartUpRouterService>(
      () => _i11.StartUpRouterService(get<_i8.LocalStorageService>()));
  gh.factory<_i12.StartUpService>(() => _i12.StartUpService(
        get<_i11.StartUpRouterService>(),
        get<_i8.LocalStorageService>(),
      ));
  gh.factory<_i13.UserLoginRepository>(
      () => _i14.HttpUserLoginRepository(get<_i6.HttpService>()));
  gh.factory<_i15.UserLoginService>(
      () => _i15.UserLoginService(get<_i13.UserLoginRepository>()));
  gh.factory<_i16.UserRepository>(
      () => _i17.HttpUserRepository(get<_i6.HttpService>()));
  gh.factory<_i18.UserService>(
      () => _i18.UserService(get<_i16.UserRepository>()));
  gh.lazySingleton<_i19.UsersScreenBloc>(() => _i19.UsersScreenBloc(
        get<_i18.UserService>(),
        get<_i8.LocalStorageService>(),
      ));
  gh.lazySingleton<_i20.DashboardScreenBloc>(() => _i20.DashboardScreenBloc(
        get<_i8.LocalStorageService>(),
        get<_i18.UserService>(),
      ));
  gh.lazySingleton<_i21.LoginScreenBloc>(() => _i21.LoginScreenBloc(
        get<_i15.UserLoginService>(),
        get<_i8.LocalStorageService>(),
      ));
  return get;
}

class _$RegisterModule extends _i22.RegisterModule {}
