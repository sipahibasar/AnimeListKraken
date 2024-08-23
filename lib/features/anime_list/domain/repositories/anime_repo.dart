import 'package:dartz/dartz.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_detail_model.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_model.dart';

import '../../../../core/error/failures.dart';

//dependency inversion and seperation of concerns

abstract class AnimeRepository {
  Future<Either<Failure, List<AnimeModel>>> getTopAnime(int page, int limit);
  //page and limit used for pagination
  Future<Either<Failure, AnimeDetailModel>> getAnimeDetail(int id);
}
