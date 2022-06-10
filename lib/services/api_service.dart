
import 'package:dio/dio.dart';
import 'package:marvel_universe_path/app/app_defaults.dart';
import 'package:marvel_universe_path/models/character_comics_container.dart';
import 'package:marvel_universe_path/models/character_data_container.dart';
import 'package:marvel_universe_path/utils/network_error_handler.dart';

class ApiService {
  late Dio _dio;

  ApiService() {
    final baseOptions = BaseOptions(
      baseUrl: AppDefaults.kBaseUrl,
      queryParameters: {'apikey': AppDefaults.kPublicKey},
    );
    _dio = Dio(baseOptions);
  }

  Future<CharacterDataContainer> getCharacters(
      Map<String, dynamic> params) async {
    try {
      final result = await _dio.get("characters", queryParameters: params);
      final json = result.data;
      return CharacterDataContainer.fromMap(json);
    } on DioError catch (error) {
      final errorMsg = handleNetworkError(error);
      return CharacterDataContainer.withError(errorMsg);
    }
  }

  Future<ComicsDataContainer> getComics(
      int charactedId, Map<String, dynamic> params) async {
    try {
      final result = await _dio.get("characters/$charactedId/comics",
          queryParameters: params);
      final json = result.data;
      return ComicsDataContainer.fromMap(json);
    } on DioError catch (error) {
      final errorMsg = handleNetworkError(error);
      return ComicsDataContainer.withError(errorMsg);
    }
  }
}
