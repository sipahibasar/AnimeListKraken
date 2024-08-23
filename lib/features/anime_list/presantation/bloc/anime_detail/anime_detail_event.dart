import 'package:equatable/equatable.dart';

abstract class AnimeDetailEvent extends Equatable {
  const AnimeDetailEvent();

  @override
  List<Object> get props => [];
}

class GetAnimeDetailEvent extends AnimeDetailEvent {
  final int malId;

  const GetAnimeDetailEvent({required this.malId});

  @override
  List<Object> get props => [malId];
}
