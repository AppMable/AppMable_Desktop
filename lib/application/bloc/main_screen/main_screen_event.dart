part of 'main_screen_bloc.dart';

abstract class MainScreenEvent extends Equatable {
  const MainScreenEvent();
}

class MainScreenEventLoad extends MainScreenEvent {
  const MainScreenEventLoad();

  @override
  List<Object?> get props => [];
}