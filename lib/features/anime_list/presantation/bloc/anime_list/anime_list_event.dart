import 'package:equatable/equatable.dart';

abstract class AnimeListEvent extends Equatable {
  const AnimeListEvent();

  @override
  List<Object?> get props => [];
}
//page 1 limit 20
class FetchAnimeList extends AnimeListEvent {
  final int limit;

  const FetchAnimeList({this.limit = 20});

  @override
  List<Object?> get props => [limit];
}
// I want to see more anime
class LoadMoreAnimeList extends AnimeListEvent {
  final int limit;

  const LoadMoreAnimeList({this.limit = 20});

  @override
  List<Object?> get props => [limit];
}
