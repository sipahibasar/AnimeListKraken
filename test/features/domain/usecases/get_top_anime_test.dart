import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newkrakenanimelist/core/error/failures.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_model.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/repositories/anime_repo.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/usecases/get_top_anime.dart';

import 'get_top_anime_test.mocks.dart';

@GenerateMocks([AnimeRepository])
void main() {
  late GetTopAnime usecase;
  late MockAnimeRepository mockAnimeRepository;

  setUp(() {
    mockAnimeRepository = MockAnimeRepository();
    usecase = GetTopAnime(mockAnimeRepository);
  });

  final tAnime = AnimeModel(
    malId: 52991,
    title: 'Sousou no Frieren',
    imageUrl: 'https://cdn.myanimelist.net/images/anime/1015/138006.jpg',
    score: 9.34,
  );

  final tAnimeList = [tAnime];
  final tPage = 1;
  final tLimit = 20;

  test('should get top anime from the repository', () async {
    // Arrange
    when(mockAnimeRepository.getTopAnime(any, any))
        .thenAnswer((_) async => Right(tAnimeList));

    // Act
    final result = await usecase(Params(page: tPage, limit: tLimit));

    // Assert
    expect(result, Right(tAnimeList));
    verify(mockAnimeRepository.getTopAnime(tPage, tLimit));
    verifyNoMoreInteractions(mockAnimeRepository);
  });

  test('should return a failure when the call to the repository is unsuccessful', () async {
    // Arrange
    when(mockAnimeRepository.getTopAnime(any, any))
        .thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await usecase(Params(page: tPage, limit: tLimit));

    // Assert
    expect(result, Left(ServerFailure()));
    verify(mockAnimeRepository.getTopAnime(tPage, tLimit));
    verifyNoMoreInteractions(mockAnimeRepository);
  });
}
