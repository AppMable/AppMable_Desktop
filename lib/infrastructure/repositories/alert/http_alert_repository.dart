import 'dart:convert';

import 'package:appmable_desktop/domain/model/objects/alert.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/repositories/alert_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';

@Injectable(as: AlertRepository)
class HttpAlertRepository implements AlertRepository {
  final HttpService _httpService;

  HttpAlertRepository(
    this._httpService,
  );

  static const String urlGetAllAlerts = 'http://127.0.0.1:8000/users/alert/?c=<userToken>';
  // static const String urlCrud = 'http://127.0.0.1:8000/users/d/alert/?id=<alertId>&c=<userToken>';
  static const String urlCrud = 'http://127.0.0.1:8000/users/d/alert/?c=<userToken>';

  @override
  Future<List<Alert>> getAlerts({
    required int userId,
    required String userToken,
  }) async {
    final String url = urlCrud.replaceAll('<userToken>', userToken);

    final Response response = await _httpService.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<Alert> alerts = [];

      List<dynamic> alertsDecoded = jsonDecode(utf8.decode(response.bodyBytes));

      for (Map<String, dynamic> alert in alertsDecoded) {
        if (alert['user_id'] == userId) alerts.add(Alert.fromMap(alert));
      }

      return alerts;
    }

    return [];
  }

  @override
  Future<Alert?> getAlert({
    required int alertId,
    required String userToken,
  }) async {
    final String url = urlCrud.replaceAll('<userToken>', userToken);

    final Response response = await _httpService.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> alertsDecoded = jsonDecode(response.body);

      for (Map<String, dynamic> alert in alertsDecoded) {
        if (alert['id'] == alertId) return Alert.fromMap(alert);
      }
    }
    return null;
  }

  @override
  Future<bool> deleteAlert({
    required int alertId,
    required String userToken,
  }) async {
    final String urlDelete = urlCrud
        .replaceAll('<alertId>', alertId.toString())
        .replaceAll('<userToken>', userToken);

    final Response response = await _httpService.delete(Uri.parse(urlDelete));

    return response.statusCode == 200;
  }

  @override
  Future<bool> createAlert({
    required Map<String, dynamic> alert,
    required String userToken,
  }) async {
    final String urlCreateAlert = urlGetAllAlerts.replaceAll('<userToken>', userToken);

    try {
      final Response response = await _httpService.post(
        Uri.parse(urlCreateAlert),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(alert),
      );
      return response.statusCode == 201;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> updateAlert({
    required Map<String, dynamic> alert,
    required String userToken,
  }) async {
    final String urlUpdateAlert =
        urlCrud.replaceAll('<alertId>', alert['id'].toString()).replaceAll('<userToken>', userToken);

    try {
      final Response response = await _httpService.put(
        Uri.parse(urlUpdateAlert),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(alert),
      );
      return response.statusCode == 200;
    } catch (_) {
      rethrow;
    }
  }
}