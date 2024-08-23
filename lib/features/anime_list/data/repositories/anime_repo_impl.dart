import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/anime_repo.dart';
import '../data_sources/anime_remote_data_source.dart';
import '../models/anime_model.dart';
import '../models/anime_detail_model.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  final AnimeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AnimeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<AnimeModel>>> getTopAnime(int page, int limit) async {
    if (await networkInfo.isConnected) { //checks networkinfo
      try {
        final response = await remoteDataSource.fetchTopAnime(page, limit);
        if (response.isRight()) {
          return response;
        } else {
          return Left(ServerFailure());
        }
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, AnimeDetailModel>> getAnimeDetail(int malId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.fetchAnimeDetail(malId);
        if (response.isRight()) {
          final AnimeDetailModel model = response.getOrElse(() => throw ServerFailure());

          // fetch and add characters to the anime detail
          final charactersResponse = await remoteDataSource.fetchAnimeCharacters(malId);
          if (charactersResponse.isRight()) {
            final characters = charactersResponse.getOrElse(() => []);
            model.characters.addAll(characters);
            //getOrElse else scenario: empty list returns
          }

          return Right(model);
        } else {
          return Left(ServerFailure());
        }
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
