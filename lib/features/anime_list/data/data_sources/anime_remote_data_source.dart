import 'package:dartz/dartz.dart';
import '../models/anime_model.dart';
import '../models/anime_detail_model.dart';
import '../../../../core/error/failures.dart';
import '../models/character_model.dart';

abstract class AnimeRemoteDataSource {
  Future<Either<Failure, List<AnimeModel>>> fetchTopAnime(int page, int limit);
  Future<Either<Failure, AnimeDetailModel>> fetchAnimeDetail(int malId);
  Future<Either<Failure, List<CharacterModel>>> fetchAnimeCharacters(int malId);
}
