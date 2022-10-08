// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/bloc/main_screen/main_screen_bloc.dart' as _i8;
import 'domain/repositories/button_api_repository.dart' as _i5;
import 'domain/services/button_service.dart' as _i7;
import 'domain/services/http_service.dart' as _i3;
import 'infrastructure/repositories/button/http_button_repository.dart'
    as _i6;
import 'infrastructure/services/http_service.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i3.HttpService>(() => _i4.FlutterHttpService());
  gh.factory<_i5.ButtonApiRepository>(
      () => _i6.HttpButtonRepository(get<_i3.HttpService>()));
  gh.factory<_i7.ButtonService>(
      () => _i7.ButtonService(get<_i5.ButtonApiRepository>()));
  gh.lazySingleton<_i8.MainScreenBloc>(
      () => _i8.MainScreenBloc(get<_i7.ButtonService>()));
  return get;
}
