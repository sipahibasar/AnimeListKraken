import 'package:chopper/chopper.dart';

part 'anime_service.chopper.dart';

@ChopperApi()
abstract class AnimeService extends ChopperService {
  @Get(path: '/top/anime')
  Future<Response> fetchTopAnime({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  @Get(path: '/anime/{mal_id}')
  Future<Response> fetchAnimeDetail(@Path('mal_id') int malId);

  @Get(path: '/anime/{mal_id}/characters')
  Future<Response> fetchAnimeCharacters(@Path('mal_id') int malId);

  static AnimeService create([ChopperClient? client]) => _$AnimeService(client);
}


ChopperClient chopper = ChopperClient(
  baseUrl: Uri.parse('https://api.jikan.moe/v4'),
  services: [
    AnimeService.create(),
  ],
  converter: JsonConverter(),
);
//from json to dart objcet