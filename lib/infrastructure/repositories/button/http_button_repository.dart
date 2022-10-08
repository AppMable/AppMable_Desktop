import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:appmable_desktop/domain/exceptions/buttons_not_found_exception.dart';
import 'package:appmable_desktop/domain/model/objects/button.dart';
import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/repositories/button_api_repository.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';

@Injectable(as: ButtonApiRepository)
class HttpButtonRepository implements ButtonApiRepository {
  final HttpService _httpService;

  HttpButtonRepository(
    this._httpService,
  );

  static const String urlApiAllButtons =
      'https://rickandmortyapi.com/api/button';

  @override
  Future<List<Button>> readAll() async =>
      await _readButtonsFromApiUrl(urlApiAllButtons);

  Future<List<Button>> _readButtonsFromApiUrl(String url) async {

    return _fakeListButton();

    final List<Button> buttons = [];

    final Response response = await _httpService.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> buttonsApiResponse = jsonDecode(response.body)['results'];

      for (var button in buttonsApiResponse) {
        Map<String, dynamic> buttonMap = {
          'id': button['id'],
          'action': button['action'],
        };
        buttons.add(Button.fromMap(buttonMap));
      }

      return buttons;
    } else {
      throw const ButtonsNotFoundException();
    }
  }

  List<Button> _fakeListButton() {
    final List<Button> buttons = [];

    String fakeHttpResponse = '''
      {
	"buttons": [{
		"id": 1,
		"action": "test1"
	}, {
		"id": 2,
		"action": "test2"
	},{
		"id": 3,
		"action": "test3"
	}]
}
    ''';

    List<dynamic> buttonsApiResponse = jsonDecode(fakeHttpResponse)['buttons'];

    for (var button in buttonsApiResponse) {
      Map<String, dynamic> buttonMap = {
        'id': button['id'],
        'action': button['action'],
      };
      buttons.add(Button.fromMap(buttonMap));
    }

    return buttons;
  }
}
