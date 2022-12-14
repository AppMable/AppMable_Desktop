import 'dart:convert';

import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/encrypter_service.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/user_service.dart';
import 'package:appmable_desktop/ui/common/widgets/user_info/user_info.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

@lazySingleton
class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final UserService _userService;
  final LocalStorageService _localStorageService;
  final EncrypterService _encrypterService;

  ChangePasswordBloc(
    this._userService,
    this._localStorageService,
    this._encrypterService,
  ) : super(const ChangePasswordInitial()) {
    on<ChangePassword>(_handleChangePassword);
    on<ClosePopupChangePassword>(_handleClosePopupChangePassword);
  }

  void _handleClosePopupChangePassword(
    ClosePopupChangePassword event,
    Emitter<ChangePasswordState> emit,
  ) {
    emit(const ChangePasswordInitial());
  }

  Future<void> _handleChangePassword(
    ChangePassword event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(const PasswordUpdating());

    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(_localStorageService.read(LoginScreen.userLoginInformation)));

    final User user = User.fromMap(jsonDecode(_localStorageService.read(UserInfo.userInformation)));

    Map<String, dynamic> userMap = user.toMap();

    userMap['password'] = _encrypterService.encrypt(event.password);

    if (userMap['date_of_birth'] != null) {
      DateTime dateOfBirth = DateFormat("yyyy-MM-dd").parse(userMap['date_of_birth']);
      userMap['date_of_birth'] = DateFormat('yyyy-MM-dd').format(dateOfBirth);
    }

    userMap.remove('health_card_identifier');
    userMap.remove('id_user_reference');

    try {
      if (await _userService.updateUser(
        user: userMap,
        userType: 'admin',
        userToken: userLoginInformation.userToken,
      )) {
        event.onSuccess();
        emit(const PasswordUpdated());
      } else {
        emit(const PasswordNotUpdated(error: 'No se ha podido actualizar la contraseña'));
      }
    } catch (_) {
      emit(const PasswordNotUpdated(error: 'No se ha podido actualizar la contraseña'));
    }
  }
}
