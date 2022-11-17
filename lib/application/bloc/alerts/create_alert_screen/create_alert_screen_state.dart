part of 'create_alert_screen_bloc.dart';

@immutable
abstract class CreateAlertScreenState extends Equatable {
  const CreateAlertScreenState();
}

class CreateAlertScreenInitial extends CreateAlertScreenState {
  const CreateAlertScreenInitial();

  @override
  List<Object> get props => [];
}

class AlertCreated extends CreateAlertScreenInitial {
  const AlertCreated();
}