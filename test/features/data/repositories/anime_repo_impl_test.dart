import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newkrakenanimelist/core/error/failures.dart';
import 'package:newkrakenanimelist/core/network/network_info.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_detail_model.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_model.dart';
import 'package:newkrakenanimelist/features/anime_list/data/data_sources/anime_remote_data_source.dart';
import 'package:newkrakenanimelist/features/anime_list/data/repositories/anime_repo_impl.dart';

import 'anime_repo_impl_test.mocks.dart';

@GenerateMocks([AnimeRemoteDataSource, NetworkInfo])
void main() {
  late AnimeRepositoryImpl repository;
  late MockAnimeRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockAnimeRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AnimeRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getTopAnime', () {
    final tPage = 1;
    final tLimit = 20;
    final tAnimeModelList = <AnimeModel>[
      AnimeModel(
        malId: 1,
        title: 'Test Anime',
        imageUrl: 'https://test.com/image.jpg',
        score: 8.5,
      ),
    ];

    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.fetchTopAnime(tPage, tLimit))
          .thenAnswer((_) async => Right(tAnimeModelList));
      // act
      repository.getTopAnime(tPage, tLimit);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote data when the call to remote data source is successful', () async {
        // arrange
        when(mockRemoteDataSource.fetchTopAnime(tPage, tLimit))
            .thenAnswer((_) async => Right(tAnimeModelList));
        // act
        final result = await repository.getTopAnime(tPage, tLimit);
        // assert
        verify(mockRemoteDataSource.fetchTopAnime(tPage, tLimit));
        expect(result, equals(Right(tAnimeModelList)));
      });

      test('should return ServerFailure when the call to remote data source is unsuccessful', () async {
        // arrange
        when(mockRemoteDataSource.fetchTopAnime(tPage, tLimit))
            .thenAnswer((_) async => Left(ServerFailure()));
        // act
        final result = await repository.getTopAnime(tPage, tLimit);
        // assert
        verify(mockRemoteDataSource.fetchTopAnime(tPage, tLimit));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test('should return NoInternetFailure when device is not connected to the internet', () async {
        // act
        final result = await repository.getTopAnime(tPage, tLimit);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(NoInternetFailure())));
      });
    });
  });

  group('getAnimeDetail', () {
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


    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.fetchAnimeDetail(tMalId))
          .thenAnswer((_) async => Right(tAnimeDetailModel));
      // act
      repository.getAnimeDetail(tMalId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote data when the call to remote data source is successful', () async {
        // arrange
        when(mockRemoteDataSource.fetchAnimeDetail(tMalId))
            .thenAnswer((_) async => Right(tAnimeDetailModel));
        when(mockRemoteDataSource.fetchAnimeCharacters(tMalId))
            .thenAnswer((_) async => Right([]));
        // act
        final result = await repository.getAnimeDetail(tMalId);
        // assert
        verify(mockRemoteDataSource.fetchAnimeDetail(tMalId));
        expect(result, equals(Right(tAnimeDetailModel)));
      });

      test('should return ServerFailure when the call to remote data source is unsuccessful', () async {
        // arrange
        when(mockRemoteDataSource.fetchAnimeDetail(tMalId))
            .thenAnswer((_) async => Left(ServerFailure()));
        // act
        final result = await repository.getAnimeDetail(tMalId);
        // assert
        verify(mockRemoteDataSource.fetchAnimeDetail(tMalId));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test('should return NoInternetFailure when device is not connected to the internet', () async {
        // act
        final result = await repository.getAnimeDetail(tMalId);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(NoInternetFailure())));
      });
    });
  });
}
