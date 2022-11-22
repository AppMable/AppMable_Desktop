part of 'update_contact_screen_bloc.dart';

abstract class UpdateContactScreenEvent extends Equatable {
  const UpdateContactScreenEvent();

  @override
  List<Object?> get props => [];
}

class UpdateContactScreenEventLoad extends UpdateContactScreenEvent {
  const UpdateContactScreenEventLoad();
}

class UpdateContactEvent extends UpdateContactScreenEvent {
  final Map<String, dynamic> contact;
  final int userId;
  final Function onSuccess;
  final Function(String error) onError;

  const UpdateContactEvent({
    required this.contact,
    required this.userId,
    required this.onSuccess,
    required this.onError,
  });

  @override
  List<Object?> get props => [
    contact,
    userId,
    onSuccess,
    onError,
  ];
}
