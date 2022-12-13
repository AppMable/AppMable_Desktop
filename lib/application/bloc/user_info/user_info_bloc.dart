import 'package:appmable_desktop/config.dart';
import 'package:appmable_desktop/domain/model/objects/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

@lazySingleton
class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc() : super(const UserInfoInitial()) {
    on<UserInfoEventLoad>(_handleLoad);
  }

  Future<void> _handleLoad(
    UserInfoEventLoad event,
    Emitter<UserInfoState> emit,
  ) async {
    emit(const UserInfoLoading());

    await Future.delayed(Duration(milliseconds: Config.defaultDelay), () {});

    emit(UserInfoLoaded(user: event.user));
  }
}
