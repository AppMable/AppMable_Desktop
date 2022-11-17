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

part 'update_contact_screen_event.dart';
part 'update_contact_screen_state.dart';

@lazySingleton
class UpdateContactScreenBloc extends Bloc<UpdateContactScreenEvent, UpdateContactScreenState> {
  final ContactsScreenBloc _contactsScreenBloc;
  final ContactService _contactService;
  final LocalStorageService _localStorageService;

  UpdateContactScreenBloc(
    this._contactsScreenBloc,
    this._contactService,
    this._localStorageService,
  ) : super(const UpdateContactScreenInitial()) {
    on<UpdateContactEvent>(_handleUpdateContact);
  }

  Future<void> _handleUpdateContact(
    UpdateContactEvent event,
    Emitter<UpdateContactScreenState> emit,
  ) async {
    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(_localStorageService.read(LoginScreen.userLoginInformation)));

    try {
      if (await _contactService.updateContact(
        contact: event.contact,
        userToken: userLoginInformation.userToken,
      )) {
        _contactsScreenBloc.add(ContactsScreenEventLoad(userId: event.contact['user_id']));
        event.onSuccess();
      } else {
        event.onError('No se ha modificar el usuario');
      }
    } catch (_) {
      event.onError('No se ha podido modificar el usuario');
    }

    emit(const ContactUpdated());
  }
}
