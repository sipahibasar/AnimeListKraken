import 'package:equatable/equatable.dart';
import '../../domain/entities/anime.dart';

class AnimeModel extends Equatable {
  final int malId;
  final String title;
  final String imageUrl;
  final double score;

  AnimeModel({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.score,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      malId: json['mal_id'],
      title: json['title'],
      imageUrl: json['images']['jpg']['image_url'],
      score: (json['score'] as num).toDouble(),
    );
  }

  Anime toEntity() {
    return Anime(
      id: malId,
      title: title,
      imageUrl: imageUrl,
      score: score,
    );
  }

  @override
  List<Object> get props => [malId, title, imageUrl, score];
}
