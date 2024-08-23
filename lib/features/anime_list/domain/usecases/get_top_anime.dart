import 'package:dartz/dartz.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_model.dart';

import '../../../../core/error/failures.dart';

import '../repositories/anime_repo.dart';

class GetTopAnime {
  final AnimeRepository repository;

  GetTopAnime(this.repository);

  Future<Either<Failure, List<AnimeModel>>> call(Params params) async {
    return await repository.getTopAnime(params.page, params.limit);
  }
}

class Params {
  final int page;
  final int limit;

  Params({required this.page, required this.limit});
}
