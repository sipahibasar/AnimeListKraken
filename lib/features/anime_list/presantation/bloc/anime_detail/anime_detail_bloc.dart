import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_anime_detail_use_case.dart';
import 'anime_detail_event.dart';
import 'anime_detail_state.dart';
import 'package:newkrakenanimelist/core/error/failures.dart';


class AnimeDetailBloc extends Bloc<AnimeDetailEvent, AnimeDetailState> {
  final GetAnimeDetail getAnimeDetail;

  AnimeDetailBloc(this.getAnimeDetail) : super(AnimeDetailInitial()) {
    on<GetAnimeDetailEvent>(_onGetAnimeDetailEvent);
  }

  Future<void> _onGetAnimeDetailEvent(
      GetAnimeDetailEvent event, Emitter<AnimeDetailState> emit) async {
    print("AnimeDetailBloc: Loading details for anime ID ${event.malId}");
    emit(AnimeDetailLoading());

    final result = await getAnimeDetail(Params(anime_detail_id: event.malId));

    result.fold(
          (failure) {
        print("AnimeDetailBloc: Failed to load anime details.");
        emit(AnimeDetailError(message: _mapFailureToMessage(failure)));
      },
          (animeDetail) {
        print("AnimeDetailBloc: Successfully loaded anime details.");
        emit(AnimeDetailLoaded(animeDetail: animeDetail));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Failure';
    } else if (failure is NoInternetFailure) {
      return 'No Internet Connection';
    } else {
      return 'Unexpected Error';
    }
  }
}
