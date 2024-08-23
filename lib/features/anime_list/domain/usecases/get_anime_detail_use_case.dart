
import 'package:dartz/dartz.dart';
import 'package:newkrakenanimelist/core/error/failures.dart';
import 'package:newkrakenanimelist/core/usecases/usecase.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/repositories/anime_repo.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_detail_model.dart';

class GetAnimeDetail extends UseCase<AnimeDetailModel, Params> {
  final AnimeRepository repository;

  GetAnimeDetail(this.repository);

  @override
  Future<Either<Failure, AnimeDetailModel>> call(Params params) async {
    return await repository.getAnimeDetail(params.anime_detail_id);
  }
}

class Params {
  final int anime_detail_id;

  Params({required this.anime_detail_id});
}
