import 'package:dio/dio.dart';
import 'package:marvel_universe_path/app/app_defaults.dart';
import 'package:marvel_universe_path/models/character_data_container.dart';
import 'package:marvel_universe_path/utils/network_error_handler.dart';

class ApiService {
  late Dio _dio;

  ApiService() {
    final baseOptions = BaseOptions(
      baseUrl: AppDefaults.baseUrl,
      queryParameters: {
        'apikey': AppDefaults.apiKey,
      },
    );
    _dio = Dio(baseOptions);
  }

  Future<CharacterDataContainer> getCharacters() async {
    try {
      final result = await _dio.get("characters");
      final json = result.data;
      return CharacterDataContainer.fromMap(json);
    } on DioError catch (error) {
      final errorMsg = handleNetworkError(error);
      return CharacterDataContainer.withError(errorMsg);
    }
  }
}
