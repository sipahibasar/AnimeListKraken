// anime_detail.dart
import 'character.dart';
import 'genre.dart';

class AnimeDetail {
  final int malId;
  final String imageUrl;
  final String title;
  final String titleEnglish;
  final String titleJapanese;
  final List<Genre> genres;
  final double score;
  final int episodes;
  final String synopsis;
  final List<Character> characters;

  AnimeDetail({
    required this.malId,
    required this.imageUrl,
    required this.title,
    required this.titleEnglish,
    required this.titleJapanese,
    required this.genres,
    required this.score,
    required this.episodes,
    required this.synopsis,
    required this.characters,
  });
}
