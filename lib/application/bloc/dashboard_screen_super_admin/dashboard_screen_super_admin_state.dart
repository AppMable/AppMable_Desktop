part of 'dashboard_screen_super_admin_bloc.dart';

@immutable
abstract class DashboardScreenSuperAdminState extends Equatable {
  const DashboardScreenSuperAdminState();
}

class DashboardScreenSuperAdminInitial extends DashboardScreenSuperAdminState {
  const DashboardScreenSuperAdminInitial();

  @override
  List<Object> get props => [];
}

class DashboardScreenSuperAdminLoading extends DashboardScreenSuperAdminInitial {
  const DashboardScreenSuperAdminLoading();
}

class DashboardScreenSuperAdminLoaded extends DashboardScreenSuperAdminState {

  const DashboardScreenSuperAdminLoaded();

  @override
  List<Object> get props => [];
}