import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:newkrakenanimelist/core/error/failures.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_model.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/usecases/get_top_anime.dart';
import 'package:newkrakenanimelist/features/anime_list/presantation/bloc/anime_list/anime_list_bloc.dart';
import 'package:newkrakenanimelist/features/anime_list/presantation/bloc/anime_list/anime_list_event.dart';
import 'package:newkrakenanimelist/features/anime_list/presantation/bloc/anime_list/anime_list_state.dart';

import 'anime_list_bloc_test.mocks.dart';

@GenerateMocks([GetTopAnime])
void main() {
  late AnimeListBloc bloc;
  late MockGetTopAnime mockGetTopAnime;

  setUp(() {
    mockGetTopAnime = MockGetTopAnime();
    bloc = AnimeListBloc(mockGetTopAnime);
  });

  final animeModel = AnimeModel(
    malId: 1,
    title: 'Anime 1',
    imageUrl: 'https://example.com/anime1.jpg',
    score: 8.5,
  );

  final animeList = [animeModel];

  group('FetchAnimeList', () {
    blocTest<AnimeListBloc, AnimeListState>(
      'emits [AnimeListLoading, AnimeListLoaded] when data is fetched successfully',
      build: () {
        when(mockGetTopAnime(any)).thenAnswer((_) async => Right(animeList));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchAnimeList(limit: 20)),
      expect: () => [
        AnimeListLoading(),
        AnimeListLoaded(animeList: animeList, hasMore: false),
      ],
      verify: (_) {
        verify(mockGetTopAnime(any)).called(1); // Changed to 'any' matcher
      },
    );

    blocTest<AnimeListBloc, AnimeListState>(
      'emits [AnimeListLoading, AnimeListError] when data fetch fails with ServerFailure',
      build: () {
        when(mockGetTopAnime(any)).thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchAnimeList(limit: 20)),
      expect: () => [
        AnimeListLoading(),
        AnimeListError('Server Error'),
      ],
      verify: (_) {
        verify(mockGetTopAnime(any)).called(1); // Changed to 'any' matcher
      },
    );

    blocTest<AnimeListBloc, AnimeListState>(
      'emits [AnimeListLoading, AnimeListError] when data fetch fails with NoInternetFailure',
      build: () {
        when(mockGetTopAnime(any)).thenAnswer((_) async => Left(NoInternetFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchAnimeList(limit: 20)),
      expect: () => [
        AnimeListLoading(),
        AnimeListError('No Internet Connection'),
      ],
      verify: (_) {
        verify(mockGetTopAnime(any)).called(1); // Changed to 'any' matcher
      },
    );
  });

  group('LoadMoreAnimeList', () {
    blocTest<AnimeListBloc, AnimeListState>(
      'emits [AnimeListLoaded] with appended data when LoadMoreAnimeList is successful',
      build: () {
        when(mockGetTopAnime(any)).thenAnswer((_) async => Right(animeList));
        bloc.emit(AnimeListLoaded(animeList: animeList, hasMore: true));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadMoreAnimeList(limit: 20)),
      expect: () => [
        AnimeListLoaded(animeList: animeList + animeList, hasMore: false),
      ],
      verify: (_) {
        verify(mockGetTopAnime(any)).called(1); // Changed to 'any' matcher
      },
    );

    blocTest<AnimeListBloc, AnimeListState>(
      'emits [AnimeListError] when LoadMoreAnimeList fails with ServerFailure',
      build: () {
        when(mockGetTopAnime(any)).thenAnswer((_) async => Left(ServerFailure()));
        bloc.emit(AnimeListLoaded(animeList: animeList, hasMore: true));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadMoreAnimeList(limit: 20)),
      expect: () => [
        AnimeListError('Server Error'),
      ],
      verify: (_) {
        verify(mockGetTopAnime(any)).called(1); // Changed to 'any' matcher
      },
    );

    blocTest<AnimeListBloc, AnimeListState>(
      'emits [AnimeListError] when LoadMoreAnimeList fails with NoInternetFailure',
      build: () {
        when(mockGetTopAnime(any)).thenAnswer((_) async => Left(NoInternetFailure()));
        bloc.emit(AnimeListLoaded(animeList: animeList, hasMore: true));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadMoreAnimeList(limit: 20)),
      expect: () => [
        AnimeListError('No Internet Connection'),
      ],
      verify: (_) {
        verify(mockGetTopAnime(any)).called(1); // Changed to 'any' matcher
      },
    );
  });
}
