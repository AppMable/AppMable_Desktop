part of 'contacts_screen_bloc.dart';

@immutable
abstract class ContactsScreenState extends Equatable {
  const ContactsScreenState();
}

class ContactsScreenInitial extends ContactsScreenState {
  const ContactsScreenInitial();

  @override
  List<Object> get props => [];
}

class ContactsScreenLoading extends ContactsScreenInitial {
  const ContactsScreenLoading();
}

class ContactsScreenLoaded extends ContactsScreenState {
  final List<Contact> contacts;

  const ContactsScreenLoaded({
    required this.contacts,
  });

  @override
  List<Object> get props => [contacts];
}