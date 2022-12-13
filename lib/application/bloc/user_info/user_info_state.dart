part of 'user_info_bloc.dart';

@immutable
abstract class UserInfoState extends Equatable {
  const UserInfoState();
}

class UserInfoInitial extends UserInfoState {
  const UserInfoInitial();

  @override
  List<Object> get props => [];
}

class UserInfoLoading extends UserInfoInitial {
  const UserInfoLoading();
}

class UserInfoLoaded extends UserInfoState {
  final User user;

  const UserInfoLoaded({
    required this.user,
  });

  @override
  List<Object> get props => [
        user,
      ];
}
