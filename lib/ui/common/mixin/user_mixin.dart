import 'dart:convert';

import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:get_it/get_it.dart';

mixin UserMixin {
  final LocalStorageService _localStorageService = GetIt.instance.get<LocalStorageService>();

  UserLoginInformation getUserLoginInformation() =>
      UserLoginInformation.fromMap(jsonDecode(_localStorageService.read(LoginScreen.userLoginInformation)));

  User getUser() => User.fromMap(jsonDecode(_localStorageService.read(DashboardScreen.userInformation)));
}
