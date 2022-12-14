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

part 'create_user_screen_event.dart';
part 'create_user_screen_state.dart';

@lazySingleton
class CreateUserScreenBloc extends Bloc<CreateUserScreenEvent, CreateUserScreenState> {
  final UsersScreenBloc _usersScreenBloc;
  final UserService _userService;
  final LocalStorageService _localStorageService;
  final EncrypterService _encrypterService;

  CreateUserScreenBloc(
    this._usersScreenBloc,
    this._userService,
    this._localStorageService,
    this._encrypterService,
  ) : super(const CreateUserScreenInitial()) {
    on<CreateUserEvent>(_handleCreateUser);
    on<CreateAdminUserEvent>(_handleCreateAdminUser);
  }

  Future<void> _handleCreateUser(
    CreateUserEvent event,
    Emitter<CreateUserScreenState> emit,
  ) async {
    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(_localStorageService.read(LoginScreen.userLoginInformation)));

    event.user['id_user_reference'] = userLoginInformation.userId;

    event.user['password'] = _encrypterService.encrypt(event.user['password']);

    DateTime dateOfBirth = DateFormat("dd-MM-yyyy").parse(event.user['date_of_birth']);

    event.user['date_of_birth'] = DateFormat('yyyy-MM-dd').format(dateOfBirth);

    try {
      if (await _userService.createUser(
        user: event.user,
      )) {
        _usersScreenBloc.add(const UsersScreenEventLoad());
        event.onSuccess();
      } else {
        event.onError('No se ha podido crear el usuario');
      }
    } catch (_) {
      event.onError('No se ha podido crear el usuario');
    }

    emit(const UserCreated());
  }

  Future<void> _handleCreateAdminUser(
    CreateAdminUserEvent event,
    Emitter<CreateUserScreenState> emit,
  ) async {
    event.user['id_user_reference'] = null;

    DateTime dateOfBirth = DateFormat("dd-MM-yyyy").parse(event.user['date_of_birth']);

    event.user['date_of_birth'] = DateFormat('yyyy-MM-dd').format(dateOfBirth);

    event.user['id_user_role'] = 2;

    try {
      if (await _userService.createAdminUser(
        user: event.user,
      )) {
        _usersScreenBloc.add(const UsersScreenEventLoad());
        event.onSuccess();
      } else {
        event.onError('No se ha podido registrarse');
      }
    } catch (_) {
      event.onError('No se ha podido registrarse');
    }

    emit(const UserAdminCreated());
  }
}
