part of 'create_contact_screen_bloc.dart';

abstract class CreateContactScreenEvent extends Equatable {
  const CreateContactScreenEvent();

  @override
  List<Object?> get props => [];
}

class CreateContactScreenEventLoad extends CreateContactScreenEvent {
  const CreateContactScreenEventLoad();
}

class CreateContactEvent extends CreateContactScreenEvent {
  final Map<String, dynamic> contact;
  final int userId;
  final Function onSuccess;
  final Function(String error) onError;

  const CreateContactEvent({
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
