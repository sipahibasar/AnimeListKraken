import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_model.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_detail_model.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/character_model.dart';
import 'package:newkrakenanimelist/features/anime_list/data/data_sources/anime_remote_data_source.dart';
import 'package:newkrakenanimelist/core/error/failures.dart';

import '../repositories/anime_repo_impl_test.mocks.dart';


@GenerateMocks([AnimeRemoteDataSource])
void main() {
  late MockAnimeRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAnimeRemoteDataSource();
  });

  group('fetchTopAnime', () {
    final tPage = 1;
    final tLimit = 20;
    final tAnimeModelList = <AnimeModel>[
      AnimeModel(malId: 1, title: 'Test Anime', imageUrl: 'https://test.com/image.jpg', score: 8.5),
    ];

    test('should return a list of AnimeModel when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.fetchTopAnime(tPage, tLimit))
          .thenAnswer((_) async => Right(tAnimeModelList));
      // act
      final result = await mockRemoteDataSource.fetchTopAnime(tPage, tLimit);
      // assert
      expect(result, Right(tAnimeModelList));
      verify(mockRemoteDataSource.fetchTopAnime(tPage, tLimit));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return a ServerFailure when the call is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.fetchTopAnime(tPage, tLimit))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final result = await mockRemoteDataSource.fetchTopAnime(tPage, tLimit);
      // assert
      expect(result, Left(ServerFailure()));
      verify(mockRemoteDataSource.fetchTopAnime(tPage, tLimit));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('fetchAnimeDetail', () {
    final tMalId = 1;
    final tAnimeDetailModel = AnimeDetailModel(
      malId: tMalId,
      title: 'Test Anime',
      titleEnglish: 'Test Anime English',  // Provide a value here
      titleJapanese: 'テストアニメ',  // Provide a value here
      imageUrl: 'https://test.com/image.jpg',
      score: 8.5,
      episodes: 12,
      genres: [],
      synopsis: 'Test Synopsis',
      characters: [],
    );


    test('should return an AnimeDetailModel when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.fetchAnimeDetail(tMalId))
          .thenAnswer((_) async => Right(tAnimeDetailModel));
      // act
      final result = await mockRemoteDataSource.fetchAnimeDetail(tMalId);
      // assert
      expect(result, Right(tAnimeDetailModel));
      verify(mockRemoteDataSource.fetchAnimeDetail(tMalId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return a ServerFailure when the call is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.fetchAnimeDetail(tMalId))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final result = await mockRemoteDataSource.fetchAnimeDetail(tMalId);
      // assert
      expect(result, Left(ServerFailure()));
      verify(mockRemoteDataSource.fetchAnimeDetail(tMalId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('fetchAnimeCharacters', () {
    final tMalId = 1;
    final tCharacterModelList = <CharacterModel>[
      CharacterModel(name: 'Test Character', imageUrl: 'https://test.com/image.jpg'),
    ];

    test('should return a list of CharacterModel when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.fetchAnimeCharacters(tMalId))
          .thenAnswer((_) async => Right(tCharacterModelList));
      // act
      final result = await mockRemoteDataSource.fetchAnimeCharacters(tMalId);
      // assert
      expect(result, Right(tCharacterModelList));
      verify(mockRemoteDataSource.fetchAnimeCharacters(tMalId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return a ServerFailure when the call is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.fetchAnimeCharacters(tMalId))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final result = await mockRemoteDataSource.fetchAnimeCharacters(tMalId);
      // assert
      expect(result, Left(ServerFailure()));
      verify(mockRemoteDataSource.fetchAnimeCharacters(tMalId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
