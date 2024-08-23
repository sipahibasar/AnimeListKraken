// character_model.dart
import '../../domain/entities/character.dart';

class CharacterModel {
  final String name;
  final String imageUrl;

  CharacterModel({
    required this.name,
    required this.imageUrl,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      name: json['character']['name'],
      imageUrl: json['character']['images']['jpg']['image_url'] ?? 'https://via.placeholder.com/150',
    );
  }

  Character toEntity() {
    return Character(
      name: name,
      imageUrl: imageUrl,
    );
  }
}
