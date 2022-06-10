import 'package:dio/dio.dart';

String handleNetworkError(DioError dioError) {
  String errorMessage = "";
  final dioErrorType = dioError.type;
  switch (dioErrorType) {
    case DioErrorType.other:
      errorMessage = 'Bağlantı Hatası. Tekrar Deneyin.';
      break;

    case DioErrorType.connectTimeout:
      errorMessage = 'Bağlantı Zaman Aşımına Uğradı. Tekrar Deneyin.';
      break;

    case DioErrorType.receiveTimeout:
      errorMessage = 'Bağlantı Zaman Aşımına Uğradı. Tekrar Deneyin.';
      break;

    case DioErrorType.cancel:
      errorMessage = 'Bağlantı Koptu. Tekrar Deneyin.';
      break;

    case DioErrorType.response:
      errorMessage =
          'Bağlantı Hatası. Hata Kodu: ${dioError.response?.statusCode.toString()}';
      if (dioError.response?.statusCode == 403) {
        errorMessage =
            'Oturum Süreniz Doldu. Lütfen Uygulamaya Tekrar Giriş Yapın.';
      }
      break;

    default:
      errorMessage = 'Belirlenemeyen Hata. Tekrar Deneyin.';
      break;
  }

  return errorMessage;
}
