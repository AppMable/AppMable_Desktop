part of 'main_screen_bloc.dart';

@immutable
abstract class MainScreenState extends Equatable {
  const MainScreenState();
}

class MainScreenInitial extends MainScreenState {
  const MainScreenInitial();

  @override
  List<Object> get props => [];
}

class MainScreenLoadingButtons extends MainScreenInitial {
  const MainScreenLoadingButtons();
}

class MainScreenButtonsLoaded extends MainScreenState {
  final List<Button> buttons;

  const MainScreenButtonsLoaded({
    required this.buttons,
  });

  @override
  List<Object> get props => [buttons];
}