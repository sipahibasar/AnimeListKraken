import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:chopper/chopper.dart';
import 'features/anime_list/data/data_sources/anime_remote_data_source_impl.dart';
import 'features/anime_list/data/data_sources/anime_service.dart';
import 'features/anime_list/data/data_sources/anime_remote_data_source.dart';
import 'features/anime_list/data/repositories/anime_repo_impl.dart';
import 'features/anime_list/domain/repositories/anime_repo.dart';
import 'features/anime_list/domain/usecases/get_top_anime.dart';
import 'features/anime_list/domain/usecases/get_anime_detail_use_case.dart';
import 'core/network/network_info.dart';
import 'features/anime_list/presantation/bloc/anime_detail/anime_detail_bloc.dart';
import 'features/anime_list/presantation/bloc/anime_list/anime_list_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize Chopper Client
  final chopperClient = ChopperClient(
    baseUrl: Uri.parse('https://api.jikan.moe/v4'),
    services: [
      AnimeService.create(),
    ],
    converter: JsonConverter(),
  );

  //! Features - Anime List

  // Bloc
  sl.registerFactory(() => AnimeListBloc(sl()));
  sl.registerFactory(() => AnimeDetailBloc(sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetTopAnime(sl()));
  sl.registerLazySingleton(() => GetAnimeDetail(sl()));

  // Repository
  sl.registerLazySingleton<AnimeRepository>(
        () => AnimeRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AnimeRemoteDataSource>(
        () => AnimeRemoteDataSourceImpl(animeService: sl()),
  );

  sl.registerLazySingleton<AnimeService>(
        () => AnimeService.create(chopperClient),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(sl()),
  );

  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => chopperClient);
}
