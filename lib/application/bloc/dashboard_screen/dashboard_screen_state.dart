part of 'dashboard_screen_bloc.dart';

@immutable
abstract class DashboardScreenState extends Equatable {
  const DashboardScreenState();
}

class DashboardScreenInitial extends DashboardScreenState {
  const DashboardScreenInitial();

  @override
  List<Object> get props => [];
}

class DashboardScreenLoading extends DashboardScreenInitial {
  const DashboardScreenLoading();
}

class DashboardScreenLoaded extends DashboardScreenState {

  const DashboardScreenLoaded();

  @override
  List<Object> get props => [];
}