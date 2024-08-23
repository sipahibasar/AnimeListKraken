import 'package:flutter_test/flutter_test.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/character_model.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/entities/character.dart';

void main() {
  group('CharacterModel', () {
    final json = {
      'character': {
        'name': 'Naruto Uzumaki',
        'images': {
          'jpg': {'image_url': 'https://via.placeholder.com/150'},
        },
      },
    };

    test('should return valid model from JSON', () {
      final characterModel = CharacterModel.fromJson(json);

      expect(characterModel.name, 'Naruto Uzumaki');
      expect(characterModel.imageUrl, 'https://via.placeholder.com/150');
    });

    test('should return Character entity', () {
      final characterModel = CharacterModel.fromJson(json);
      final character = characterModel.toEntity();

      expect(character, isA<Character>());
      expect(character.name, 'Naruto Uzumaki');
      expect(character.imageUrl, 'https://via.placeholder.com/150');
    });

    test('should handle missing image URL gracefully', () {
      final incompleteJson = {
        'character': {
          'name': 'Naruto Uzumaki',
          'images': {'jpg': {}},
        },
      };

      final characterModel = CharacterModel.fromJson(incompleteJson);
      expect(characterModel.imageUrl, 'https://via.placeholder.com/150');
    });
  });
}
