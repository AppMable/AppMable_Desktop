import 'dart:convert';

import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/user_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'users_screen_event.dart';
part 'users_screen_state.dart';

@lazySingleton
class UsersScreenBloc extends Bloc<UsersScreenEvent, UsersScreenState> {
  final UserService _userService;
  final LocalStorageService _localStorageService;

  UsersScreenBloc(
    this._userService,
    this._localStorageService,
  ) : super(const UsersScreenInitial()) {
    on<UsersScreenEventLoad>(_handleLoad);
    on<UsersScreenDeleteEvent>(_handleDeleteUser);
    add(const UsersScreenEventLoad());
  }

  Future<void> _handleLoad(
    UsersScreenEventLoad event,
    Emitter<UsersScreenState> emit,
  ) async {
    emit(const UsersScreenLoading());

    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(_localStorageService.read(LoginScreen.userLoginInformation)));

    List<User> users = await _userService.getUsers(
      userReferenceId: userLoginInformation.userId,
      userToken: userLoginInformation.userToken,
    );

    emit(UsersScreenLoaded(users: users));
  }

  Future<void> _handleDeleteUser(
    UsersScreenDeleteEvent event,
    Emitter<UsersScreenState> emit,
  ) async {
    emit(const UsersScreenLoading());

    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(_localStorageService.read(LoginScreen.userLoginInformation)));

    try {
      if (await _userService.deleteUser(
        userId: event.userId,
        userType: 'user',
        userToken: userLoginInformation.userToken,
      )) {
        event.onSuccess();
        add(const UsersScreenEventLoad());
      } else {
        event.onError('No se ha podido eliminar');
      }
    } catch (_) {
      event.onError('No se ha podido eliminar por algo raro');
    }
  }
}
