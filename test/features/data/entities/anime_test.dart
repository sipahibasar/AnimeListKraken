import 'package:flutter_test/flutter_test.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/entities/anime.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_model.dart';

void main() {
  group('Anime Entity', () {
    test('should correctly create Anime entity from AnimeModel', () {
      final json = {
        'mal_id': 52991,
        'title': 'Sousou no Frieren',
        'images': {
          'jpg': {
            'image_url': 'https://cdn.myanimelist.net/images/anime/1015/138006.jpg'
          }
        },
        'score': 9.34,
      };

      final animeModel = AnimeModel.fromJson(json);
      final anime = animeModel.toEntity();

      expect(anime.id, 52991);
      expect(anime.title, 'Sousou no Frieren');
      expect(anime.imageUrl, 'https://cdn.myanimelist.net/images/anime/1015/138006.jpg');
      expect(anime.score, 9.34);
    });
  });
}
