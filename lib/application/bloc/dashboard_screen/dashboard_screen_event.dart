part of 'dashboard_screen_bloc.dart';

abstract class DashboardScreenEvent extends Equatable {
  const DashboardScreenEvent();
}

class DashboardScreenEventLoad extends DashboardScreenEvent {
  const DashboardScreenEventLoad();

  @override
  List<Object?> get props => [];
}

class DashboardScreenEventReset extends DashboardScreenEvent {
  const DashboardScreenEventReset();

  @override
  List<Object?> get props => [];
}