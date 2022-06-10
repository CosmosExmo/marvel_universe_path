import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:marvel_universe_path/app/app_defaults.dart';

class HasTimestampHelper {
  static get timestamp => DateTime.now().millisecondsSinceEpoch;
  static calculateHash(String timestamp) {
    var bytes = utf8
        .encode(timestamp + AppDefaults.kPrivateKey + AppDefaults.kPublicKey);
    return md5.convert(bytes).toString();
  }
}
