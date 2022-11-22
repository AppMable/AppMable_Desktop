part of 'update_contact_screen_bloc.dart';

@immutable
abstract class UpdateContactScreenState extends Equatable {
  const UpdateContactScreenState();
}

class UpdateContactScreenInitial extends UpdateContactScreenState {
  const UpdateContactScreenInitial();

  @override
  List<Object> get props => [];
}

class ContactUpdated extends UpdateContactScreenInitial {
  const ContactUpdated();
}