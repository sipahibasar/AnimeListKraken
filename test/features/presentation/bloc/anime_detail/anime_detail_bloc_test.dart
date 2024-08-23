import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:newkrakenanimelist/core/error/failures.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_detail_model.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/character_model.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/genre_model.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/usecases/get_anime_detail_use_case.dart';
import 'package:newkrakenanimelist/features/anime_list/presantation/bloc/anime_detail/anime_detail_bloc.dart';
import 'package:newkrakenanimelist/features/anime_list/presantation/bloc/anime_detail/anime_detail_event.dart';
import 'package:newkrakenanimelist/features/anime_list/presantation/bloc/anime_detail/anime_detail_state.dart';

import 'anime_detail_bloc_test.mocks.dart';

@GenerateMocks([GetAnimeDetail])
void main() {
  late AnimeDetailBloc bloc;
  late MockGetAnimeDetail mockGetAnimeDetail;

  setUp(() {
    mockGetAnimeDetail = MockGetAnimeDetail();
    bloc = AnimeDetailBloc(mockGetAnimeDetail);
  });

  final animeDetail = AnimeDetailModel(
    malId: 1,
    title: 'Anime 1',
    titleJapanese: "titleJapanese",
    titleEnglish: "titleEnglish",
    imageUrl: 'https://image.url/anime1.jpg',
    score: 8.5,
    episodes: 24,
    synopsis: 'This is the synopsis of Anime 1.',
    genres: [GenreModel(id: 1, name: 'Action'), GenreModel(id: 2, name: 'Adventure')],
    characters: [
      CharacterModel(name: 'Character 1', imageUrl: 'https://image.url/char1.jpg'),
      CharacterModel(name: 'Character 2', imageUrl: 'https://image.url/char2.jpg'),
    ],
  );

  group('GetAnimeDetailEvent', () {
    blocTest<AnimeDetailBloc, AnimeDetailState>(
      'emits [AnimeDetailLoading, AnimeDetailLoaded] when data is returned successfully',
      build: () {
        when(mockGetAnimeDetail(any)).thenAnswer((_) async => Right(animeDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(GetAnimeDetailEvent(malId: 1)),
      expect: () => [
        AnimeDetailLoading(),
        AnimeDetailLoaded(animeDetail: animeDetail),
      ],
      verify: (_) {
        verify(mockGetAnimeDetail(argThat(
          predicate((params) => params is Params && params.anime_detail_id == 1),
        ))).called(1);
      },
    );

    blocTest<AnimeDetailBloc, AnimeDetailState>(
      'emits [AnimeDetailLoading, AnimeDetailError] when a server failure occurs',
      build: () {
        when(mockGetAnimeDetail(any)).thenAnswer((_) async => Left(ServerFailure()));  // Ensure the mock returns ServerFailure
        return bloc;
      },
      act: (bloc) => bloc.add(GetAnimeDetailEvent(malId: 1)),
      expect: () => [
        AnimeDetailLoading(),
        AnimeDetailError(message: 'Server Failure'),  // Expecting 'Server Failure'
      ],
      verify: (_) {
        verify(mockGetAnimeDetail(argThat(
          predicate((params) => params is Params && params.anime_detail_id == 1),
        ))).called(1);
      },
    );


    blocTest<AnimeDetailBloc, AnimeDetailState>(
      'emits [AnimeDetailLoading, AnimeDetailError] when there is no internet connection',
      build: () {
        when(mockGetAnimeDetail(any)).thenAnswer((_) async => Left(NoInternetFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetAnimeDetailEvent(malId: 1)),
      expect: () => [
        AnimeDetailLoading(),
        AnimeDetailError(message: 'No Internet Connection'),
      ],
      verify: (_) {
        verify(mockGetAnimeDetail(argThat(
          predicate((params) => params is Params && params.anime_detail_id == 1),
        ))).called(1);
      },
    );
  });
}
