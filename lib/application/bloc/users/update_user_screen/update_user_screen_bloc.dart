import 'dart:convert';

import 'package:appmable_desktop/application/bloc/users/users_screen/users_screen_bloc.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/encrypter_service.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/user_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

part 'update_user_screen_event.dart';
part 'update_user_screen_state.dart';

@lazySingleton
class UpdateUserScreenBloc extends Bloc<UpdateUserScreenEvent, UpdateUserScreenState> {
  final UsersScreenBloc _usersScreenBloc;
  final UserService _userService;
  final LocalStorageService _localStorageService;
  final EncrypterService _encrypterService;

  UpdateUserScreenBloc(
    this._usersScreenBloc,
    this._userService,
    this._localStorageService,
    this._encrypterService,
  ) : super(const UpdateUserScreenInitial()) {
    on<UpdateUserEvent>(_handleUpdateUser);
  }

  Future<void> _handleUpdateUser(
    UpdateUserEvent event,
    Emitter<UpdateUserScreenState> emit,
  ) async {
    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(_localStorageService.read(LoginScreen.userLoginInformation)));

    if (event.user['date_of_birth'] != null) {
      DateTime dateOfBirth = DateFormat("dd-MM-yyyy").parse(event.user['date_of_birth']);
      event.user['date_of_birth'] = DateFormat('yyyy-MM-dd').format(dateOfBirth);
    }

    event.user['password'] = _encrypterService.encrypt(event.user['password']);

    event.user.remove('id_user_role');

    try {
      if (await _userService.updateUser(
        user: event.user,
        userType: 'user',
        userToken: userLoginInformation.userToken,
      )) {
        _usersScreenBloc.add(const UsersScreenEventLoad());
        event.onSuccess();
      } else {
        event.onError('No se ha modificar el usuario');
      }
    } catch (_) {
      event.onError('No se ha podido modificar el usuario');
    }

    emit(const UserUpdated());
  }
}
