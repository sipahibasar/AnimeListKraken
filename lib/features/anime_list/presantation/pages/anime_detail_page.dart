import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../components/anime_detail_view.dart';
import '../../../../components/error_message.dart';
import '../../../../components/loading_indicator.dart';
import '../../domain/usecases/get_anime_detail_use_case.dart';
import '../bloc/anime_detail/anime_detail_bloc.dart';
import '../bloc/anime_detail/anime_detail_event.dart';
import '../bloc/anime_detail/anime_detail_state.dart';

class AnimeDetailPage extends StatelessWidget {
  final int animeId;
  final AnimeDetailBloc? animeDetailBloc;


  AnimeDetailPage({required this.animeId,this.animeDetailBloc});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Anime Detail')),
      body: BlocProvider(
          create: (context) =>(animeDetailBloc?? AnimeDetailBloc(GetIt.instance<GetAnimeDetail>()))
          ..add(GetAnimeDetailEvent(malId: animeId)),
        child: BlocBuilder<AnimeDetailBloc, AnimeDetailState>(
          builder: (context, state) {
            if (state is AnimeDetailLoading) {
              return LoadingIndicator();
            } else if (state is AnimeDetailLoaded) {
              return AnimeDetailView(animeDetail: state.animeDetail);
            } else if (state is AnimeDetailError) {
              return ErrorMessage(message: state.message);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
