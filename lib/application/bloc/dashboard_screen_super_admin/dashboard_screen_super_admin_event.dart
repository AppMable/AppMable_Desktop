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

class DashboardScreenSuperAdminDeleteEvent extends DashboardScreenSuperAdminEvent {
  final int userId;
  final Function onSuccess;
  final Function(String error) onError;

  const DashboardScreenSuperAdminDeleteEvent({
    required this.userId,
    required this.onSuccess,
    required this.onError,
  });

  @override
  List<Object?> get props => [
        userId,
        onSuccess,
        onError,
      ];
}
