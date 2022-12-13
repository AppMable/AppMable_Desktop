part of 'dashboard_screen_super_admin_bloc.dart';

abstract class DashboardScreenSuperAdminEvent extends Equatable {
  const DashboardScreenSuperAdminEvent();
}

class DashboardScreenSuperAdminEventLoad extends DashboardScreenSuperAdminEvent {
  const DashboardScreenSuperAdminEventLoad();

  @override
  List<Object?> get props => [];
}

class DashboardScreenSuperAdminEventReset extends DashboardScreenSuperAdminEvent {
  const DashboardScreenSuperAdminEventReset();

  @override
  List<Object?> get props => [];
}