// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/bloc/alerts/alerts_screen/alerts_screen_bloc.dart' as _i24;
import 'application/bloc/alerts/create_alert_screen/create_alert_screen_bloc.dart'
    as _i30;
import 'application/bloc/alerts/update_alert_screen/update_alert_screen_bloc.dart'
    as _i36;
import 'application/bloc/contacts/contacts_screen/contacts_screen_bloc.dart'
    as _i29;
import 'application/bloc/contacts/create_contact_screen/create_contact_screen_bloc.dart'
    as _i31;
import 'application/bloc/contacts/update_contact_screen/update_contact_screen_bloc.dart'
    as _i37;
import 'application/bloc/dashboard_screen/dashboard_screen_bloc.dart' as _i33;
import 'application/bloc/dashboard_screen_super_admin/dashboard_screen_super_admin_bloc.dart'
    as _i34;
import 'application/bloc/login_screen/login_screen_bloc.dart' as _i35;
import 'application/bloc/user_info/user_info_bloc.dart' as _i13;
import 'application/bloc/users/change_password/change_password_bloc.dart'
    as _i25;
import 'application/bloc/users/create_user_screen/create_user_screen_bloc.dart'
    as _i32;
import 'application/bloc/users/update_user_screen/update_user_screen_bloc.dart'
    as _i38;
import 'application/bloc/users/users_screen/users_screen_bloc.dart' as _i20;
import 'domain/repositories/alert_repository.dart' as _i21;
import 'domain/repositories/contact_repository.dart' as _i26;
import 'domain/repositories/user_login_repository.dart' as _i14;
import 'domain/repositories/user_repository.dart' as _i17;
import 'domain/services/alert_service.dart' as _i23;
import 'domain/services/connectivity_checker_service.dart' as _i4;
import 'domain/services/contact_service.dart' as _i28;
import 'domain/services/http_service.dart' as _i6;
import 'domain/services/navigator_service.dart' as _i9;
import 'domain/services/start_up_router_service.dart' as _i11;
import 'domain/services/start_up_service.dart' as _i12;
import 'domain/services/storage/local_storage_service.dart' as _i8;
import 'domain/services/storage/session_storage_service.dart' as _i10;
import 'domain/services/user_login_service.dart' as _i16;
import 'domain/services/user_service.dart' as _i19;
import 'infrastructure/repositories/alert/http_alert_repository.dart' as _i22;
import 'infrastructure/repositories/contact/http_contact_repository.dart'
    as _i27;
import 'infrastructure/repositories/user/http_user_repository.dart' as _i18;
import 'infrastructure/repositories/userLogin/http_user_login_repository.dart'
    as _i15;
import 'infrastructure/services/flutter_connectivity_checker_service.dart'
    as _i5;
import 'infrastructure/services/http_service.dart' as _i7;
import 'injection.dart' as _i39; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i13.UserInfoBloc>(() => _i13.UserInfoBloc());
  gh.factory<_i14.UserLoginRepository>(
      () => _i15.HttpUserLoginRepository(get<_i6.HttpService>()));
  gh.factory<_i16.UserLoginService>(
      () => _i16.UserLoginService(get<_i14.UserLoginRepository>()));
  gh.factory<_i17.UserRepository>(
      () => _i18.HttpUserRepository(get<_i6.HttpService>()));
  gh.factory<_i19.UserService>(
      () => _i19.UserService(get<_i17.UserRepository>()));
  gh.lazySingleton<_i20.UsersScreenBloc>(() => _i20.UsersScreenBloc(
        get<_i19.UserService>(),
        get<_i8.LocalStorageService>(),
      ));
  gh.factory<_i21.AlertRepository>(
      () => _i22.HttpAlertRepository(get<_i6.HttpService>()));
  gh.factory<_i23.AlertService>(
      () => _i23.AlertService(get<_i21.AlertRepository>()));
  gh.lazySingleton<_i24.AlertsScreenBloc>(() => _i24.AlertsScreenBloc(
        get<_i23.AlertService>(),
        get<_i8.LocalStorageService>(),
      ));
  gh.lazySingleton<_i25.ChangePasswordBloc>(() => _i25.ChangePasswordBloc(
        get<_i19.UserService>(),
        get<_i8.LocalStorageService>(),
      ));
  gh.factory<_i26.ContactRepository>(
      () => _i27.HttpContactRepository(get<_i6.HttpService>()));
  gh.factory<_i28.ContactService>(
      () => _i28.ContactService(get<_i26.ContactRepository>()));
  gh.lazySingleton<_i29.ContactsScreenBloc>(() => _i29.ContactsScreenBloc(
        get<_i28.ContactService>(),
        get<_i8.LocalStorageService>(),
      ));
  gh.lazySingleton<_i30.CreateAlertScreenBloc>(() => _i30.CreateAlertScreenBloc(
        get<_i24.AlertsScreenBloc>(),
        get<_i23.AlertService>(),
        get<_i8.LocalStorageService>(),
      ));
  gh.lazySingleton<_i31.CreateContactScreenBloc>(
      () => _i31.CreateContactScreenBloc(
            get<_i29.ContactsScreenBloc>(),
            get<_i28.ContactService>(),
            get<_i8.LocalStorageService>(),
          ));
  gh.lazySingleton<_i32.CreateUserScreenBloc>(() => _i32.CreateUserScreenBloc(
        get<_i20.UsersScreenBloc>(),
        get<_i19.UserService>(),
        get<_i8.LocalStorageService>(),
      ));
  gh.lazySingleton<_i33.DashboardScreenBloc>(() => _i33.DashboardScreenBloc(
        get<_i8.LocalStorageService>(),
        get<_i19.UserService>(),
        get<_i13.UserInfoBloc>(),
      ));
  gh.lazySingleton<_i34.DashboardScreenSuperAdminBloc>(
      () => _i34.DashboardScreenSuperAdminBloc(
            get<_i8.LocalStorageService>(),
            get<_i19.UserService>(),
            get<_i13.UserInfoBloc>(),
          ));
  gh.lazySingleton<_i35.LoginScreenBloc>(() => _i35.LoginScreenBloc(
        get<_i16.UserLoginService>(),
        get<_i8.LocalStorageService>(),
        get<_i11.StartUpRouterService>(),
        get<_i33.DashboardScreenBloc>(),
        get<_i34.DashboardScreenSuperAdminBloc>(),
      ));
  gh.lazySingleton<_i36.UpdateAlertScreenBloc>(() => _i36.UpdateAlertScreenBloc(
        get<_i24.AlertsScreenBloc>(),
        get<_i23.AlertService>(),
        get<_i8.LocalStorageService>(),
      ));
  gh.lazySingleton<_i37.UpdateContactScreenBloc>(
      () => _i37.UpdateContactScreenBloc(
            get<_i29.ContactsScreenBloc>(),
            get<_i28.ContactService>(),
            get<_i8.LocalStorageService>(),
          ));
  gh.lazySingleton<_i38.UpdateUserScreenBloc>(() => _i38.UpdateUserScreenBloc(
        get<_i20.UsersScreenBloc>(),
        get<_i19.UserService>(),
        get<_i8.LocalStorageService>(),
      ));
  return get;
}

class _$RegisterModule extends _i39.RegisterModule {}
