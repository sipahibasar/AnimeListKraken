import 'package:equatable/equatable.dart';
import '../../../data/models/anime_model.dart';

abstract class AnimeListState extends Equatable {
  const AnimeListState();

  @override
  List<Object> get props => [];
}

class AnimeListInitial extends AnimeListState {}

class AnimeListLoading extends AnimeListState {}

class AnimeListLoaded extends AnimeListState {
  final List<AnimeModel> animeList;
  final bool hasMore;

  const AnimeListLoaded({
    required this.animeList,
    required this.hasMore,
  });

  @override
  List<Object> get props => [animeList, hasMore];
}

class AnimeListError extends AnimeListState {
  final String message;

  const AnimeListError(this.message);

  @override
  List<Object> get props => [message];
}
