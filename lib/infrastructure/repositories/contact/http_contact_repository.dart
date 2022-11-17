import 'dart:convert';

import 'package:appmable_desktop/domain/model/objects/contact.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/repositories/contact_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';

@Injectable(as: ContactRepository)
class HttpContactRepository implements ContactRepository {
  final HttpService _httpService;

  HttpContactRepository(
    this._httpService,
  );

  static const String urlGetAllContacts = 'http://127.0.0.1:8000/users/contact/?c=<userToken>';
  // static const String urlCrud = 'http://127.0.0.1:8000/users/d/contact/?id=<contactId>&c=<userToken>';
  static const String urlCrud = 'http://127.0.0.1:8000/users/d/contact/?c=<userToken>';

  @override
  Future<List<Contact>> getContacts({
    required int userId,
    required String userToken,
  }) async {
    final String url = urlCrud.replaceAll('<userToken>', userToken);

    final Response response = await _httpService.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<Contact> contacts = [];

      List<dynamic> contactsDecoded = jsonDecode(utf8.decode(response.bodyBytes));

      for (Map<String, dynamic> contact in contactsDecoded) {
        if (contact['user_id'] == userId) contacts.add(Contact.fromMap(contact));
      }

      return contacts;
    }

    return [];
  }

  @override
  Future<Contact?> getContact({
    required int contactId,
    required String userToken,
  }) async {
    final String url = urlCrud.replaceAll('<userToken>', userToken);

    final Response response = await _httpService.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> contactsDecoded = jsonDecode(response.body);

      for (Map<String, dynamic> contact in contactsDecoded) {
        if (contact['id'] == contactId) return Contact.fromMap(contact);
      }
    }
    return null;
  }

  @override
  Future<bool> deleteContact({
    required int contactId,
    required String userToken,
  }) async {
    final String urlDelete = urlCrud
        .replaceAll('<contactId>', contactId.toString())
        .replaceAll('<userToken>', userToken);

    final Response response = await _httpService.delete(Uri.parse(urlDelete));

    return response.statusCode == 200;
  }

  @override
  Future<bool> createContact({
    required Map<String, dynamic> contact,
    required String userToken,
  }) async {
    final String urlCreateContact = urlGetAllContacts.replaceAll('<userToken>', userToken);

    try {
      final Response response = await _httpService.post(
        Uri.parse(urlCreateContact),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(contact),
      );
      return response.statusCode == 201;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> updateContact({
    required Map<String, dynamic> contact,
    required String userToken,
  }) async {
    final String urlUpdateContact =
        urlCrud.replaceAll('<contactId>', contact['id'].toString()).replaceAll('<userToken>', userToken);

    try {
      final Response response = await _httpService.put(
        Uri.parse(urlUpdateContact),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(contact),
      );
      return response.statusCode == 200;
    } catch (_) {
      rethrow;
    }
  }
}
