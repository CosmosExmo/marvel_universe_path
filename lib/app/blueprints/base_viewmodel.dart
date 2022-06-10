import 'package:flutter/foundation.dart';
import 'package:marvel_universe_path/services/api_service.dart';

abstract class BaseViewModel extends ChangeNotifier {
  //Api Service instance
  @protected
  final apiService = ApiService();

  /// This can be used as a init loading status
  /// Upon showing the view the loading indicator is shown until the api request is complete
  /// After that this can be set to true and the content is shown
  @protected
  bool _viewDidLoad = false;

  bool get viewDidLoad => _viewDidLoad;

  /// This can be used to set the viewLoading status
  @protected
  void setViewDidLoad(bool value) {
    if (value != _viewDidLoad) {
      _viewDidLoad = value;
      notifyListeners();
    }
  }

  /// This can be used to fetch ApiResponseModel
  @protected
  Future<void> getData();

  /// This can be used to dispose
  @protected
  void disposeModel();
}