part of 'create_alert_screen_bloc.dart';

abstract class CreateAlertScreenEvent extends Equatable {
  const CreateAlertScreenEvent();

  @override
  List<Object?> get props => [];
}

class CreateAlertScreenEventLoad extends CreateAlertScreenEvent {
  const CreateAlertScreenEventLoad();
}

class CreateAlertEvent extends CreateAlertScreenEvent {
  final Map<String, dynamic> alert;
  final Function onSuccess;
  final Function(String error) onError;

  const CreateAlertEvent({
    required this.alert,
    required this.onSuccess,
    required this.onError,
  });

  @override
  List<Object?> get props => [
    alert,
    onSuccess,
    onError,
  ];
}
