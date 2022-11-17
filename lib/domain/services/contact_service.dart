import 'package:appmable_desktop/domain/model/objects/contact.dart';
import 'package:appmable_desktop/domain/repositories/contact_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ContactService {
  final ContactRepository _contactRepository;

  const ContactService(
    this._contactRepository,
  );

  Future<List<Contact>> getContacts({
    required int userId,
    required String userToken,
  }) async {
    return _contactRepository.getContacts(
      userId: userId,
      userToken: userToken,
    );
  }

  Future<Contact?> getContact({
    required int contactId,
    required userToken,
  }) async {
    return _contactRepository.getContact(
      contactId: contactId,
      userToken: userToken,
    );
  }

  Future<bool> deleteContact({
    required int contactId,
    required userToken,
  }) async {
    return _contactRepository.deleteContact(
      contactId: contactId,
      userToken: userToken,
    );
  }

  Future<bool> createContact({
    required Map<String, dynamic> contact,
    required userToken,
  }) async {
    return _contactRepository.createContact(
      contact: contact,
      userToken: userToken,
    );
  }

  Future<bool> updateContact({
    required Map<String, dynamic> contact,
    required userToken,
  }) async {
    return _contactRepository.updateContact(
      contact: contact,
      userToken: userToken,
    );
  }
}
