part of 'contacts_screen_bloc.dart';

abstract class ContactsScreenEvent extends Equatable {
  const ContactsScreenEvent();

  @override
  List<Object?> get props => [];
}

class ContactsScreenEventReset extends ContactsScreenEvent {
  const ContactsScreenEventReset();
}

class ContactsScreenEventLoad extends ContactsScreenEvent {
  final int userId;

  const ContactsScreenEventLoad({
    required this.userId,
  });
}

class ContactsScreenDeleteEvent extends ContactsScreenEvent {
  final int contactId;
  final int userId;
  final Function onSuccess;
  final Function(String error) onError;

  const ContactsScreenDeleteEvent({
    required this.contactId,
    required this.userId,
    required this.onSuccess,
    required this.onError,
  });

  @override
  List<Object?> get props => [
        contactId,
        userId,
        onSuccess,
        onError,
      ];
}
