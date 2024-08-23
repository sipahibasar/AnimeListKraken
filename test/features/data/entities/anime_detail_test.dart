import 'package:flutter_test/flutter_test.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/entities/anime_detail.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_detail_model.dart';

void main() {
  group('AnimeDetail Entity', () {
    test('should correctly create AnimeDetail from AnimeDetailModel', () {
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
      final animeDetail = animeDetailModel.toEntity();

      expect(animeDetail.malId, 52991);
      expect(animeDetail.imageUrl, 'https://cdn.myanimelist.net/images/anime/1015/138006.jpg');
      expect(animeDetail.title, 'Sousou no Frieren');
      expect(animeDetail.titleEnglish, 'Frieren: Beyond Journey\'s End');
      expect(animeDetail.titleJapanese, '葬送のフリーレン');
      expect(animeDetail.genres.length, 3);
      expect(animeDetail.genres[0].name, 'Adventure');
      expect(animeDetail.score, 9.34);
      expect(animeDetail.episodes, 28);
      expect(animeDetail.synopsis, 'During their decade-long quest to defeat the Demon King...');
    });
  });
}
