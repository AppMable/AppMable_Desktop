import 'package:appmable_desktop/domain/model/objects/contact.dart';

abstract class ContactRepository {
  Future<List<Contact>> getContacts({
    required int userId,
    required String userToken,
  });

  Future<Contact?> getContact({
    required int contactId,
    required String userToken,
  });

  Future<bool> deleteContact({
    required int contactId,
    required String userToken,
  });

  Future<bool> createContact({
    required Map<String, dynamic> contact,
    required String userToken,
  });

  Future<bool> updateContact({
    required Map<String, dynamic> contact,
    required String userToken,
  });
}
