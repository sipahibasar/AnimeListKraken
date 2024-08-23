// anime.dart
import 'package:equatable/equatable.dart';

class Anime extends Equatable {
  final int id;
  final String title;
  final String imageUrl;
  final double score;

  Anime({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.score,
  });

  @override
  List<Object?> get props => [id, title, imageUrl, score];
}
