
import 'package:appmable_desktop/domain/services/api_test_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

@lazySingleton
class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final ApiTestService _apiTestService;

  MainScreenBloc(
    this._apiTestService,
  ) : super(const MainScreenInitial()) {
    on<MainScreenEventLoad>(_handleLoad);
    add(const MainScreenEventLoad());
  }

  void _handleLoad(
      MainScreenEventLoad event,
    Emitter<MainScreenState> emit,
  ) async {
    try {
      emit(MainScreenLoaded(message: await _apiTestService.readMessage()));
    } on Exception catch (_, e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
