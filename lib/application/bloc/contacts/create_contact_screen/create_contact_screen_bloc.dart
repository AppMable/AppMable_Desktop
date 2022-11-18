import 'dart:convert';

import 'package:appmable_desktop/application/bloc/contacts/contacts_screen/contacts_screen_bloc.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/contact_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'create_contact_screen_event.dart';
part 'create_contact_screen_state.dart';

@lazySingleton
class CreateContactScreenBloc extends Bloc<CreateContactScreenEvent, CreateContactScreenState> {
  final ContactsScreenBloc _contactsScreenBloc;
  final ContactService _contactService;
  final LocalStorageService _localStorageService;

  CreateContactScreenBloc(
    this._contactsScreenBloc,
    this._contactService,
    this._localStorageService,
  ) : super(const CreateContactScreenInitial()) {
    on<CreateContactEvent>(_handleCreateContact);
  }

  Future<void> _handleCreateContact(
    CreateContactEvent event,
    Emitter<CreateContactScreenState> emit,
  ) async {
    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(_localStorageService.read(LoginScreen.userLoginInformation)));

    try {
      if (await _contactService.createContact(
        contact: event.contact,
        userToken: userLoginInformation.userToken,
      )) {
        _contactsScreenBloc.add(ContactsScreenEventLoad(userId: event.userId));
        event.onSuccess();
        emit(const ContactCreated());
      } else {
        event.onError('No se ha podido crear el usuario');
      }
    } catch (_) {
      event.onError('No se ha podido crear el usuario');
    }
  }
}
