// lib/features/anime_list/presentation/bloc/anime_list/anime_list_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:newkrakenanimelist/core/error/failures.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_model.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/usecases/get_top_anime.dart';
import 'anime_list_event.dart';
import 'anime_list_state.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_model.dart';


class AnimeListBloc extends Bloc<AnimeListEvent, AnimeListState> {
  final GetTopAnime getTopAnime;
  int currentPage = 1;
  bool isLoadingMore = false;

  AnimeListBloc(this.getTopAnime) : super(AnimeListInitial()) {
    on<FetchAnimeList>(_onFetchAnimeList);
    on<LoadMoreAnimeList>(_onLoadMoreAnimeList);
  }

  void _onFetchAnimeList(FetchAnimeList event, Emitter<AnimeListState> emit) async {
    emit(AnimeListLoading());
    final failureOrAnime = await getTopAnime(Params(page: 1, limit: event.limit));
    currentPage = 1; // Reset the page counter on new fetch
    emit(_eitherLoadedOrErrorState(failureOrAnime, event.limit));
  }

  void _onLoadMoreAnimeList(LoadMoreAnimeList event, Emitter<AnimeListState> emit) async {
    if (isLoadingMore) return;
    isLoadingMore = true;
    currentPage++;
    final failureOrAnime = await getTopAnime(Params(page: currentPage, limit: event.limit));
    emit(_eitherLoadedOrErrorState(failureOrAnime, event.limit, append: true));
    isLoadingMore = false;
  }

  AnimeListState _eitherLoadedOrErrorState(
      Either<Failure, List<AnimeModel>> failureOrAnime,
      int limit, {
        bool append = false,
      }) {
    return failureOrAnime.fold(
          (failure) => AnimeListError(_mapFailureToMessage(failure)),
          (animeList) {
        if (state is AnimeListLoaded && append) {
          final List<AnimeModel> updatedList = List.from((state as AnimeListLoaded).animeList)..addAll(animeList);
          return AnimeListLoaded(animeList: updatedList, hasMore: animeList.length == limit);
        } else {
          return AnimeListLoaded(animeList: animeList, hasMore: animeList.length == limit);
        }
      },
    );
  }


  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Error';
      case NoInternetFailure:
        return 'No Internet Connection';
      default:
        return 'Unexpected Error';
    }
  }
}
