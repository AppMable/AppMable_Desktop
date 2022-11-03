part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
}

class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial();

  @override
  List<Object> get props => [];
}

class PasswordUpdating extends ChangePasswordInitial {
  const PasswordUpdating();
}

class PasswordUpdated extends ChangePasswordInitial {
  const PasswordUpdated();
}

class PasswordNotUpdated extends ChangePasswordInitial {
  final String error;

  const PasswordNotUpdated({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
