part of 'update_alert_screen_bloc.dart';

abstract class UpdateAlertScreenEvent extends Equatable {
  const UpdateAlertScreenEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAlertScreenEventLoad extends UpdateAlertScreenEvent {
  const UpdateAlertScreenEventLoad();
}

class UpdateAlertEvent extends UpdateAlertScreenEvent {
  final Map<String, dynamic> alert;
  final int userId;
  final Function onSuccess;
  final Function(String error) onError;

  const UpdateAlertEvent({
    required this.alert,
    required this.userId,
    required this.onSuccess,
    required this.onError,
  });

  @override
  List<Object?> get props => [
    alert,
    userId,
    onSuccess,
    onError,
  ];
}
