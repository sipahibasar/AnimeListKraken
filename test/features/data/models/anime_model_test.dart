import 'package:flutter_test/flutter_test.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_model.dart';

void main() {
  group('AnimeModel', () {
    test('should correctly parse from JSON', () {
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

      expect(animeModel.malId, 52991);
      expect(animeModel.title, 'Sousou no Frieren');
      expect(animeModel.imageUrl, 'https://cdn.myanimelist.net/images/anime/1015/138006.jpg');
      expect(animeModel.score, 9.34);
    });
  });
}
