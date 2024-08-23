import 'package:flutter_test/flutter_test.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_detail_model.dart';

void main() {
  group('AnimeDetailModel', () {
    test('should correctly parse from JSON', () {
      final json = {
        'mal_id': 52991,
        'images': {
          'jpg': {
            'image_url': 'https://cdn.myanimelist.net/images/anime/1015/138006.jpg'
          }
        },
        'title': 'Sousou no Frieren',
        'title_english': 'Frieren: Beyond Journey\'s End',
        'title_japanese': '葬送のフリーレン',
        'genres': [
          {'mal_id': 2, 'name': 'Adventure'},
          {'mal_id': 8, 'name': 'Drama'},
          {'mal_id': 10, 'name': 'Fantasy'}
        ],
        'score': 9.34,
        'episodes': 28,
        'synopsis': 'During their decade-long quest to defeat the Demon King...',
      };

      final animeDetailModel = AnimeDetailModel.fromJson(json);

      expect(animeDetailModel.malId, 52991);
      expect(animeDetailModel.imageUrl, 'https://cdn.myanimelist.net/images/anime/1015/138006.jpg');
      expect(animeDetailModel.title, 'Sousou no Frieren');
      expect(animeDetailModel.titleEnglish, 'Frieren: Beyond Journey\'s End');
      expect(animeDetailModel.titleJapanese, '葬送のフリーレン');
      expect(animeDetailModel.genres.length, 3);
      expect(animeDetailModel.genres[0].name, 'Adventure');
      expect(animeDetailModel.score, 9.34);
      expect(animeDetailModel.episodes, 28);
      expect(animeDetailModel.synopsis, 'During their decade-long quest to defeat the Demon King...');
    });
  });
}
