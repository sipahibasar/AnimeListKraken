import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newkrakenanimelist/core/error/failures.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_detail_model.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/repositories/anime_repo.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/usecases/get_anime_detail_use_case.dart';

import 'get_anime_detail_use_case_test.mocks.dart';

@GenerateMocks([AnimeRepository])
void main() {
  late GetAnimeDetail usecase;
  late MockAnimeRepository mockAnimeRepository;

  setUp(() {
    mockAnimeRepository = MockAnimeRepository();
    usecase = GetAnimeDetail(mockAnimeRepository);
  });

  final tAnimeDetail = AnimeDetailModel(
    malId: 52991,
    imageUrl: "https://cdn.myanimelist.net/images/anime/1015/138006.jpg",
    title: 'Sousou no Frieren',
    titleEnglish: "Frieren: Beyond Journey's End",
    titleJapanese: '葬送のフリーレン',
    genres: [],
    score: 9.34,
    episodes: 28,
    synopsis: "During their decade-long quest to defeat the Demon King...",
    characters: [],
  );

  final tId = 1;

  test('should get anime detail from the repository', () async {
    // Arrange
    when(mockAnimeRepository.getAnimeDetail(any))
        .thenAnswer((_) async => Right(tAnimeDetail));

    // Act
    final result = await usecase(Params(anime_detail_id: tId));

    // Assert
    expect(result, Right(tAnimeDetail));
    verify(mockAnimeRepository.getAnimeDetail(tId));
    verifyNoMoreInteractions(mockAnimeRepository);
  });

  test('should return a failure when the call to the repository is unsuccessful', () async {
    // Arrange
    when(mockAnimeRepository.getAnimeDetail(any))
        .thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await usecase(Params(anime_detail_id: tId));

    // Assert
    expect(result, Left(ServerFailure()));
    verify(mockAnimeRepository.getAnimeDetail(tId));
    verifyNoMoreInteractions(mockAnimeRepository);
  });
}
