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

class MainScreenLoading extends MainScreenInitial {
  const MainScreenLoading();
}

class MainScreenLoaded extends MainScreenState {
  final String message;

  const MainScreenLoaded({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}