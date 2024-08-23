import 'package:dartz/dartz.dart';
import 'package:chopper/chopper.dart';
import '../models/anime_model.dart';
import '../models/anime_detail_model.dart';
import '../models/character_model.dart';
import '../../../../core/error/failures.dart';
import '../data_sources/anime_service.dart';
import '../data_sources/anime_remote_data_source.dart';

class AnimeRemoteDataSourceImpl implements AnimeRemoteDataSource {
  final AnimeService animeService;

  AnimeRemoteDataSourceImpl({required this.animeService});

  @override
  Future<Either<Failure, List<AnimeModel>>> fetchTopAnime(int page, int limit) async {
    try {
      final Response response = await animeService.fetchTopAnime(page: page, limit: limit);
      if (response.isSuccessful) {
        final List<dynamic> data = response.body['data'] ?? [];
        final List<AnimeModel> animeList = data.map((animeJson) => AnimeModel.fromJson(animeJson)).toList();
        return Right(animeList);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AnimeDetailModel>> fetchAnimeDetail(int malId) async {
    try {
      final Response response = await animeService.fetchAnimeDetail(malId);
      if (response.isSuccessful) {
        final data = response.body['data'];
        if (data == null) {
          return Left(ServerFailure());
        }
        final AnimeDetailModel animeDetail = AnimeDetailModel.fromJson(data);
        return Right(animeDetail);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CharacterModel>>> fetchAnimeCharacters(int malId) async {
    try {
      final Response response = await animeService.fetchAnimeCharacters(malId);
      if (response.isSuccessful) {
        final List<dynamic> data = response.body['data'] ?? [];
        final List<CharacterModel> characters = data.map((characterJson) => CharacterModel.fromJson(characterJson)).toList();
        return Right(characters);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
