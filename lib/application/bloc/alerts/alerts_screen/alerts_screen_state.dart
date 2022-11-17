part of 'alerts_screen_bloc.dart';

@immutable
abstract class AlertsScreenState extends Equatable {
  const AlertsScreenState();
}

class AlertsScreenInitial extends AlertsScreenState {
  const AlertsScreenInitial();

  @override
  List<Object> get props => [];
}

class AlertsScreenLoading extends AlertsScreenInitial {
  const AlertsScreenLoading();
}

class AlertsScreenLoaded extends AlertsScreenState {
  final List<Alert> alerts;

  const AlertsScreenLoaded({
    required this.alerts,
  });

  @override
  List<Object> get props => [alerts];
}