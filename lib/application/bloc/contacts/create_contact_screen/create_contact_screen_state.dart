part of 'create_contact_screen_bloc.dart';

@immutable
abstract class CreateContactScreenState extends Equatable {
  const CreateContactScreenState();
}

class CreateContactScreenInitial extends CreateContactScreenState {
  const CreateContactScreenInitial();

  @override
  List<Object> get props => [];
}

class ContactCreated extends CreateContactScreenInitial {
  const ContactCreated();
}