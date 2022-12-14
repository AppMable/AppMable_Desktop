import 'package:appmable_desktop/domain/model/value_object/response.dart';
import 'package:appmable_desktop/domain/services/http_service.dart';
import 'package:injectable/injectable.dart';

import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:flutter/services.dart' show rootBundle;

@singleton
class EncrypterService {
  late Encrypter _encrypter;

  final HttpService _httpService;

  EncrypterService(
    this._httpService,
  );

  Future<void> init() async {
    RSAPublicKey publicKey = await _loadPublicKey();
    RSAPrivateKey privateKey = await _loadPrivateKey();
    _encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privateKey));
  }

  String encrypt(final String message) => _encrypter.encrypt(message).base64;

  String decrypt(final String message) => _encrypter.decrypt64(message);

  Future<RSAPublicKey> _loadPublicKey() async {
    final Response responsePublicKey =
        await _httpService.get(Uri.parse('${const String.fromEnvironment("server")}users/public/'));

    String publicPem = responsePublicKey.body.replaceAll('PublicKey(', '').replaceAll(')', '').replaceAll(', ', ',');
    List<String> publicKeyArray = publicPem.split(',');

    return RSAPublicKey(BigInt.parse(publicKeyArray[0]), BigInt.parse(publicKeyArray[1]));
  }

  Future<RSAPrivateKey> _loadPrivateKey() async {
    final String privatePem = await rootBundle.loadString('assets/certificates/private.pem');
    return RSAKeyParser().parse(privatePem) as RSAPrivateKey;
  }
}
