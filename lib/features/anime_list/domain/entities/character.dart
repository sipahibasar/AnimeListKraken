// character.dart
import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final String name;
  final String imageUrl;

  Character({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [name, imageUrl];
}
