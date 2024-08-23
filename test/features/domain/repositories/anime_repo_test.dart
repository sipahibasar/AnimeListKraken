
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:newkrakenanimelist/core/error/failures.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_detail_model.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_model.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/entities/anime.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/entities/anime_detail.dart';
import '../usecases/get_anime_detail_use_case_test.mocks.dart';

void main() {
  late MockAnimeRepository mockAnimeRepository;

  setUp(() {
    mockAnimeRepository = MockAnimeRepository();
  });

  final tPage = 1;
  final tLimit = 20;
  final tId = 1;

  final tAnimeList = [
    AnimeModel(malId: 52991 , title: "Sousou no Frieren",imageUrl:"https://cdn.myanimelist.net/images/anime/1015/138006.jpg" ,score:9.34),
    AnimeModel(malId: 5114, title: "Fullmetal Alchemist: Brotherhood",imageUrl:"https://cdn.myanimelist.net/images/anime/1208/94745.jpg" ,score:9.09),
  ];

  final tAnimeDetail = AnimeDetailModel(
    malId: 52991,
    imageUrl: "https://cdn.myanimelist.net/images/anime/1015/138006.jpg",
    title: "Sousou no Frieren",
    titleEnglish: "Frieren: Beyond Journey's End",
    titleJapanese: "葬送のフリーレン",
    genres: [],
    score: 9.34,
    episodes: 28,
    synopsis:  "During their decade-long quest to defeat the Demon King...",
    characters: [],
  );

  group('AnimeRepository Tests', () {
    test('should return a list of anime when getTopAnime is called', () async {
      when(mockAnimeRepository.getTopAnime(tPage, tLimit))
          .thenAnswer((_) async => Right(tAnimeList));

      final result = await mockAnimeRepository.getTopAnime(tPage, tLimit);

      expect(result, Right(tAnimeList));
      verify(mockAnimeRepository.getTopAnime(tPage, tLimit));
      verifyNoMoreInteractions(mockAnimeRepository);
    });

    test('should return anime detail when getAnimeDetail is called', () async {
      when(mockAnimeRepository.getAnimeDetail(tId))
          .thenAnswer((_) async => Right(tAnimeDetail));

      final result = await mockAnimeRepository.getAnimeDetail(tId);

      expect(result, Right(tAnimeDetail));
      verify(mockAnimeRepository.getAnimeDetail(tId));
      verifyNoMoreInteractions(mockAnimeRepository);
    });

    test('should return a Failure when getTopAnime fails', () async {
      when(mockAnimeRepository.getTopAnime(tPage, tLimit))
          .thenAnswer((_) async => Left(ServerFailure()));

      final result = await mockAnimeRepository.getTopAnime(tPage, tLimit);

      expect(result, Left(ServerFailure()));
      verify(mockAnimeRepository.getTopAnime(tPage, tLimit));
      verifyNoMoreInteractions(mockAnimeRepository);
    });

    test('should return a Failure when getAnimeDetail fails', () async {
      when(mockAnimeRepository.getAnimeDetail(tId))
          .thenAnswer((_) async => Left(ServerFailure()));

      final result = await mockAnimeRepository.getAnimeDetail(tId);

      expect(result, Left(ServerFailure()));
      verify(mockAnimeRepository.getAnimeDetail(tId));
      verifyNoMoreInteractions(mockAnimeRepository);
    });
  });
}
