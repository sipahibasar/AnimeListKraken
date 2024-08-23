import '../../domain/entities/anime_detail.dart';
import 'genre_model.dart';
import 'character_model.dart';

class AnimeDetailModel {
  final int malId;
  final String imageUrl;
  final String title;
  final String titleEnglish;
  final String titleJapanese;
  final List<GenreModel> genres;
  final double score;
  final int episodes;
  final String synopsis;
  final List<CharacterModel> characters;

  AnimeDetailModel({
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

  factory AnimeDetailModel.fromJson(Map<String, dynamic> json) {
    return AnimeDetailModel(
      malId: json['mal_id'],
      imageUrl: json['images']['jpg']['image_url'],
      title: json['title'],
      titleEnglish: json['title_english'] ?? '',
      titleJapanese: json['title_japanese'] ?? '',
      genres: (json['genres'] as List?)?.map((e) => GenreModel.fromJson(e)).toList() ?? [],
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      episodes: json['episodes'] ?? 0,
      synopsis: json['synopsis'] ?? '',
      characters: [], // Initialize as empty list and populate later
    );
  }

  AnimeDetail toEntity() {
    return AnimeDetail(
      malId: malId,
      imageUrl: imageUrl,
      title: title,
      titleEnglish: titleEnglish,
      titleJapanese: titleJapanese,
      genres: genres.map((e) => e.toEntity()).toList(),
      score: score,
      episodes: episodes,
      synopsis: synopsis,
      characters: characters.map((e) => e.toEntity()).toList(),
    );
  }
}
