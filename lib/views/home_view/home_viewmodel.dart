import 'package:flutter/material.dart';
import 'package:marvel_universe_path/app/blueprints/base_viewmodel.dart';
import 'package:marvel_universe_path/models/character_data_container.dart';
import 'package:marvel_universe_path/utils/hash_timestamp_helper.dart';
import 'package:marvel_universe_path/views/detail_view/detail_view.dart';

class HomeViewModel extends BaseViewModel {
  final ScrollController _scrollController = ScrollController();
  ScrollController get controller => _scrollController;
  @override
  void disposeModel() {
    _scrollController.dispose();
  }

  @override
  Future<void> getData() async {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchData();
      }
    });
    await _fetchData();
    super.setViewDidLoad(true);
  }

  List<Character> _items = [];
  List<Character> get items => _items.toList();

  int _offset = 0;

  Future<void> _fetchData() async {
    final ts = HasTimestampHelper.timestamp;
    final hash = HasTimestampHelper.calculateHash(ts.toString());
    final params = {
      'ts': ts,
      'hash': hash,
      'limit': "30",
      'offset': _offset,
    };
    final model = await super.apiService.getCharacters(params);
    if (model.status) {
      if (_items.isEmpty) {
        _items = model.data;
      } else {
        _items.addAll(model.data);
        notifyListeners();
      }
      _offset += 30;
      return;
    }
  }

  void navigateToDetailView(BuildContext context, Character character) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailView(character: character),
      ),
    );
  }
}
