import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_universe_path/models/character_comics_container.dart';

import 'mocks/json_mocks.dart';

void main() async {
  group("ComicsDataContainer Model Tests", () {
    test(
      "initilize ComicsDataContainer from json",
      () async {
        final json = JsonMocks.characterComicsJsonMock;

        final model = ComicsDataContainer.fromMap(json);

        expect(model, isA<ComicsDataContainer>());
      },
    );
  });
}
