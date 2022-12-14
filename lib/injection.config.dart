// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/bloc/alerts/alerts_screen/alerts_screen_bloc.dart' as _i23;
import 'application/bloc/alerts/create_alert_screen/create_alert_screen_bloc.dart'
    as _i28;
import 'application/bloc/alerts/update_alert_screen/update_alert_screen_bloc.dart'
    as _i35;
import 'application/bloc/contacts/contacts_screen/contacts_screen_bloc.dart'
    as _i27;
import 'application/bloc/contacts/create_contact_screen/create_contact_screen_bloc.dart'
    as _i29;
import 'application/bloc/contacts/update_contact_screen/update_contact_screen_bloc.dart'
    as _i36;
import 'application/bloc/dashboard_screen/dashboard_screen_bloc.dart' as _i30;
import 'application/bloc/dashboard_screen_super_admin/dashboard_screen_super_admin_bloc.dart'
    as _i31;
import 'application/bloc/login_screen/login_screen_bloc.dart' as _i33;
import 'application/bloc/user_info/user_info_bloc.dart' as _i12;
import 'application/bloc/users/change_password/change_password_bloc.dart'
    as _i38;
import 'application/bloc/users/create_user_screen/create_user_screen_bloc.dart'
    as _i39;
import 'application/bloc/users/update_user_screen/update_user_screen_bloc.dart'
    as _i37;
import 'application/bloc/users/users_screen/users_screen_bloc.dart' as _i19;
import 'domain/repositories/alert_repository.dart' as _i20;
import 'domain/repositories/contact_repository.dart' as _i24;
import 'domain/repositories/user_login_repository.dart' as _i13;
import 'domain/repositories/user_repository.dart' as _i16;
import 'domain/services/alert_service.dart' as _i22;
import 'domain/services/connectivity_checker_service.dart' as _i4;
import 'domain/services/contact_service.dart' as _i26;
import 'domain/services/encrypter_service.dart' as _i32;
import 'domain/services/http_service.dart' as _i6;
import 'domain/services/navigator_service.dart' as _i9;
import 'domain/services/start_up_router_service.dart' as _i11;
import 'domain/services/start_up_service.dart' as _i34;
import 'domain/services/storage/local_storage_service.dart' as _i8;
import 'domain/services/storage/session_storage_service.dart' as _i10;
import 'domain/services/user_login_service.dart' as _i15;
import 'domain/services/user_service.dart' as _i18;
import 'infrastructure/repositories/alert/http_alert_repository.dart' as _i21;
import 'infrastructure/repositories/contact/http_contact_repository.dart'
    as _i25;
import 'infrastructure/repositories/user/http_user_repository.dart' as _i17;
import 'infrastructure/repositories/userLogin/http_user_login_repository.dart'
    as _i14;
import 'infrastructure/services/flutter_connectivity_checker_service.dart'
    as _i5;
import 'infrastructure/services/http_service.dart' as _i7;
import 'injection.dart' as _i40; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i12.UserInfoBloc>(() => _i12.UserInfoBloc());
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
  gh.factory<_i20.AlertRepository>(
      () => _i21.HttpAlertRepository(get<_i6.HttpService>()));
  gh.factory<_i22.AlertService>(
      () => _i22.AlertService(get<_i20.AlertRepository>()));
  gh.lazySingleton<_i23.AlertsScreenBloc>(() => _i23.AlertsScreenBloc(
        get<_i22.AlertService>(),
        get<_i8.LocalStorageService>(),
      ));
  gh.factory<_i24.ContactRepository>(
      () => _i25.HttpContactRepository(get<_i6.HttpService>()));
  gh.factory<_i26.ContactService>(
      () => _i26.ContactService(get<_i24.ContactRepository>()));
  gh.lazySingleton<_i27.ContactsScreenBloc>(() => _i27.ContactsScreenBloc(
        get<_i26.ContactService>(),
        get<_i8.LocalStorageService>(),
      ));
  gh.lazySingleton<_i28.CreateAlertScreenBloc>(() => _i28.CreateAlertScreenBloc(
        get<_i23.AlertsScreenBloc>(),
        get<_i22.AlertService>(),
        get<_i8.LocalStorageService>(),
      ));
  gh.lazySingleton<_i29.CreateContactScreenBloc>(
      () => _i29.CreateContactScreenBloc(
            get<_i27.ContactsScreenBloc>(),
            get<_i26.ContactService>(),
            get<_i8.LocalStorageService>(),
          ));
  gh.lazySingleton<_i30.DashboardScreenBloc>(() => _i30.DashboardScreenBloc(
        get<_i8.LocalStorageService>(),
        get<_i18.UserService>(),
        get<_i12.UserInfoBloc>(),
      ));
  gh.lazySingleton<_i31.DashboardScreenSuperAdminBloc>(
      () => _i31.DashboardScreenSuperAdminBloc(
            get<_i8.LocalStorageService>(),
            get<_i18.UserService>(),
            get<_i12.UserInfoBloc>(),
          ));
  gh.singleton<_i32.EncrypterService>(
      _i32.EncrypterService(get<_i6.HttpService>()));
  gh.lazySingleton<_i33.LoginScreenBloc>(() => _i33.LoginScreenBloc(
        get<_i15.UserLoginService>(),
        get<_i8.LocalStorageService>(),
        get<_i11.StartUpRouterService>(),
        get<_i30.DashboardScreenBloc>(),
        get<_i31.DashboardScreenSuperAdminBloc>(),
        get<_i32.EncrypterService>(),
      ));
  gh.factory<_i34.StartUpService>(() => _i34.StartUpService(
        get<_i11.StartUpRouterService>(),
        get<_i8.LocalStorageService>(),
        get<_i32.EncrypterService>(),
      ));
  gh.lazySingleton<_i35.UpdateAlertScreenBloc>(() => _i35.UpdateAlertScreenBloc(
        get<_i23.AlertsScreenBloc>(),
        get<_i22.AlertService>(),
        get<_i8.LocalStorageService>(),
      ));
  gh.lazySingleton<_i36.UpdateContactScreenBloc>(
      () => _i36.UpdateContactScreenBloc(
            get<_i27.ContactsScreenBloc>(),
            get<_i26.ContactService>(),
            get<_i8.LocalStorageService>(),
          ));
  gh.lazySingleton<_i37.UpdateUserScreenBloc>(() => _i37.UpdateUserScreenBloc(
        get<_i19.UsersScreenBloc>(),
        get<_i18.UserService>(),
        get<_i8.LocalStorageService>(),
      ));
  gh.lazySingleton<_i38.ChangePasswordBloc>(() => _i38.ChangePasswordBloc(
        get<_i18.UserService>(),
        get<_i8.LocalStorageService>(),
        get<_i32.EncrypterService>(),
      ));
  gh.lazySingleton<_i39.CreateUserScreenBloc>(() => _i39.CreateUserScreenBloc(
        get<_i19.UsersScreenBloc>(),
        get<_i18.UserService>(),
        get<_i8.LocalStorageService>(),
        get<_i32.EncrypterService>(),
      ));
  return get;
}

class _$RegisterModule extends _i40.RegisterModule {}
