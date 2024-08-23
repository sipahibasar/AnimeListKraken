import 'package:flutter_test/flutter_test.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/genre_model.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/entities/genre.dart';

void main() {
  group('GenreModel', () {
    final json = {
      'mal_id': 1,
      'name': 'Action',
    };

    test('should return valid model from JSON', () {
      final genreModel = GenreModel.fromJson(json);

      expect(genreModel.id, 1);
      expect(genreModel.name, 'Action');
    });

    test('should return Genre entity', () {
      final genreModel = GenreModel.fromJson(json);
      final genre = genreModel.toEntity();

      expect(genre, isA<Genre>());
      expect(genre.id, 1);
      expect(genre.name, 'Action');
    });
  });
}
