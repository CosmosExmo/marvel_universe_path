import 'package:flutter/foundation.dart';

abstract class ApiResponse {
  @protected
  late int code;
  late bool status;
  late String? errorMsg;
  late String? copyright;
  late String? attributionText;
  late String? attributionHTML;
  late String? etag;

  @protected
  @mustCallSuper
  ApiResponse.fromMap(Map<String, dynamic>? map) {
    code = map!['code'];
    status = map['status'] == "Ok";
    copyright = map['copyright'];
    attributionText = map['attributionText'];
    attributionHTML = map['attributionHTML'];
    etag = map['etag'];
  }

  @protected
  @mustCallSuper
  ApiResponse.withError(String? error) {
    code = -1;
    status = false;
    errorMsg = error;
  }

  @protected
  Map<String, dynamic> toMap();
}
