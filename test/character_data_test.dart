import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_universe_path/models/character_data_container.dart';

import 'mocks/json_mocks.dart';

void main() async {
  group("CharacterDataContainer Model Tests", () {
    test(
      "initilize CharacterDataContainer from json",
      () async {
        final json = JsonMocks.characterListJsonMock;

        final model = CharacterDataContainer.fromMap(json);

        expect(model, isA<CharacterDataContainer>());
      },
    );
  });
}
