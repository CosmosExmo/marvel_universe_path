import 'package:marvel_universe_path/app/blueprints/base_viewmodel.dart';
import 'package:marvel_universe_path/models/character_comics_container.dart';
import 'package:marvel_universe_path/models/character_data_container.dart';
import 'package:marvel_universe_path/utils/hash_timestamp_helper.dart';

class DetailViewModel extends BaseViewModel {
  final Character character;

  DetailViewModel(this.character);

  @override
  void disposeModel() {}

  @override
  Future<void> getData() async {
    await _fetchData();
    super.setViewDidLoad(true);
  }

  List<ComicData> _items = [];
  List<ComicData> get items => _items.toList();

  Future<void> _fetchData() async {
    final ts = HasTimestampHelper.timestamp;
    final hash = HasTimestampHelper.calculateHash(ts.toString());
    final params = {
      'ts': ts,
      'hash': hash,
      'limit': "10",
      'startYear': 2005,
      'orderBy': "onsaleDate",
    };
    final model = await super.apiService.getComics(character.id, params);
    if (model.status) {
      _items = model.data;
      return;
    }
  }
}
