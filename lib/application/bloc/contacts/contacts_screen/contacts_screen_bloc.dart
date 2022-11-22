import 'dart:convert';

import 'package:appmable_desktop/config.dart';
import 'package:appmable_desktop/domain/model/objects/contact.dart';
import 'package:appmable_desktop/domain/model/value_object/user_login_information.dart';
import 'package:appmable_desktop/domain/services/storage/local_storage_service.dart';
import 'package:appmable_desktop/domain/services/contact_service.dart';
import 'package:appmable_desktop/ui/screens/login_screen/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'contacts_screen_event.dart';
part 'contacts_screen_state.dart';

@lazySingleton
class ContactsScreenBloc extends Bloc<ContactsScreenEvent, ContactsScreenState> {
  final ContactService _contactService;
  final LocalStorageService _localStorageService;

  ContactsScreenBloc(
    this._contactService,
    this._localStorageService,
  ) : super(const ContactsScreenInitial()) {
    on<ContactsScreenEventReset>(_handleReset);
    on<ContactsScreenEventLoad>(_handleLoad);
    on<ContactsScreenDeleteEvent>(_handleDeleteContact);
  }

  void _handleReset(
    ContactsScreenEventReset event,
    Emitter<ContactsScreenState> emit,
  ) {
    emit(const ContactsScreenInitial());
  }

  Future<void> _handleLoad(
    ContactsScreenEventLoad event,
    Emitter<ContactsScreenState> emit,
  ) async {
    emit(const ContactsScreenLoading());
    await Future.delayed(Duration(milliseconds: Config.defaultDelay), () {});

    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(_localStorageService.read(LoginScreen.userLoginInformation)));

    List<Contact> contacts = await _contactService.getContacts(
      userId: event.userId,
      userToken: userLoginInformation.userToken,
    );

    emit(ContactsScreenLoaded(contacts: contacts));
  }

  Future<void> _handleDeleteContact(
    ContactsScreenDeleteEvent event,
    Emitter<ContactsScreenState> emit,
  ) async {
    emit(const ContactsScreenLoading());

    final UserLoginInformation userLoginInformation =
        UserLoginInformation.fromMap(jsonDecode(_localStorageService.read(LoginScreen.userLoginInformation)));

    try {
      if (await _contactService.deleteContact(
        contactId: event.contactId,
        userToken: userLoginInformation.userToken,
      )) {
        event.onSuccess();
        add(ContactsScreenEventLoad(userId: event.userId));
      } else {
        event.onError('No se ha podido eliminar');
      }
    } catch (_) {
      event.onError('No se ha podido eliminar por algo raro');
    }
  }
}
