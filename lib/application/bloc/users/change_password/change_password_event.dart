part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object?> get props => [];
}

class ClosePopupChangePassword extends ChangePasswordEvent {
  const ClosePopupChangePassword();
}

class ChangePassword extends ChangePasswordEvent {
  final String password;
  final Function onSuccess;

  const ChangePassword({
    required this.password,
    required this.onSuccess,
  });

  @override
  List<Object?> get props => [
    password,
    onSuccess,
  ];
}
