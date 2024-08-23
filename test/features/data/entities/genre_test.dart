import 'package:flutter_test/flutter_test.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/entities/genre.dart';

void main() {
  group('Genre Entity', () {
    final genre = Genre(id: 1, name: 'Action');

    test('should return correct id', () {
      expect(genre.id, 1);
    });

    test('should return correct name', () {
      expect(genre.name, 'Action');
    });

    test('props should contain id and name', () {
      expect(genre.props, [1, 'Action']);
    });
  });
}
