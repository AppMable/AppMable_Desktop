part of 'user_info_bloc.dart';

abstract class UserInfoEvent extends Equatable {
  const UserInfoEvent();
}

class UserInfoEventLoad extends UserInfoEvent {
  final User user;

  const UserInfoEventLoad({
    required this.user,
  });

  @override
  List<Object?> get props => [
        user,
      ];
}
