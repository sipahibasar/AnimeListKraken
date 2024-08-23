// genre_model.dart
import '../../domain/entities/genre.dart';

class GenreModel {
  final int id;
  final String name;

  GenreModel({
    required this.id,
    required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['mal_id'],
      name: json['name'],
    );
  }


  Genre toEntity() {
    return Genre(
      id: id,
      name: name,
    );
  }
}
