
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:appmable_desktop/domain/model/objects/button.dart';
import 'package:appmable_desktop/domain/services/button_service.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

@lazySingleton
class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final ButtonService _buttonsService;

  MainScreenBloc(
    this._buttonsService,
  ) : super(const MainScreenInitial()) {
    on<MainScreenEventLoadAllButtons>(_handleLoadAllButtons);
    add(const MainScreenEventLoadAllButtons());
  }

  void _handleLoadAllButtons(
      MainScreenEventLoadAllButtons event,
    Emitter<MainScreenState> emit,
  ) async {
    try {
      emit(MainScreenButtonsLoaded(buttons: await _buttonsService.readAll()));
    } on Exception catch (_, e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
