import 'package:marvel_universe_path/app/blueprints/base_viewmodel.dart';
import 'package:marvel_universe_path/models/character_data_container.dart';

class HomeViewModel extends BaseViewModel {
  @override
  void disposeModel() {}

  @override
  Future<void> getData() async {
    await _fetchData();
    super.setViewDidLoad(true);
  }

  List<Character> _items = [];
  List<Character> get items => _items;

  Future<void> _fetchData() async {
    final model = await super.apiService.getCharacters();
    _items = model.data;
  }
}
