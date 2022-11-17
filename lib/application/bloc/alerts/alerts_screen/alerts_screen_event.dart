part of 'alerts_screen_bloc.dart';

abstract class AlertsScreenEvent extends Equatable {
  const AlertsScreenEvent();

  @override
  List<Object?> get props => [];
}

class AlertsScreenEventLoad extends AlertsScreenEvent {
  final int userId;

  const AlertsScreenEventLoad({
    required this.userId,
  });
}

class AlertsScreenDeleteEvent extends AlertsScreenEvent {
  final int alertId;
  final int userId;
  final Function onSuccess;
  final Function(String error) onError;

  const AlertsScreenDeleteEvent({
    required this.alertId,
    required this.userId,
    required this.onSuccess,
    required this.onError,
  });

  @override
  List<Object?> get props => [
        alertId,
        userId,
        onSuccess,
        onError,
      ];
}
