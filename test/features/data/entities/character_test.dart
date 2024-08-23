import 'package:flutter_test/flutter_test.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/entities/character.dart';

void main() {
  group('Character Entity', () {
    final character = Character(name: 'Naruto Uzumaki', imageUrl: 'https://via.placeholder.com/150');

    test('should return correct name', () {
      expect(character.name, 'Naruto Uzumaki');
    });

    test('should return correct imageUrl', () {
      expect(character.imageUrl, 'https://via.placeholder.com/150');
    });

    test('props should contain name and imageUrl', () {
      expect(character.props, ['Naruto Uzumaki', 'https://via.placeholder.com/150']);
    });
  });
}
