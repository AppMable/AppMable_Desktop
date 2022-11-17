part of 'update_alert_screen_bloc.dart';

@immutable
abstract class UpdateAlertScreenState extends Equatable {
  const UpdateAlertScreenState();
}

class UpdateAlertScreenInitial extends UpdateAlertScreenState {
  const UpdateAlertScreenInitial();

  @override
  List<Object> get props => [];
}

class AlertUpdated extends UpdateAlertScreenInitial {
  const AlertUpdated();
}