import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../components/anime_list_card.dart';
import '../../../../components/bottom_loader.dart';
import '../../../../components/error_message.dart';
import '../../../../components/loading_indicator.dart';
import '../bloc/anime_list/anime_list_bloc.dart';
import '../bloc/anime_list/anime_list_event.dart';
import '../bloc/anime_list/anime_list_state.dart';

class AnimeListPage extends StatefulWidget {
  @override
  _AnimeListPageState createState() => _AnimeListPageState();
}

class _AnimeListPageState extends State<AnimeListPage> {
  final ScrollController _scrollController = ScrollController();
  final int _limit = 20;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchInitialAnimeList();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchInitialAnimeList() {
    context.read<AnimeListBloc>().add(FetchAnimeList(limit: _limit));
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<AnimeListBloc>().add(LoadMoreAnimeList(limit: _limit));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<AnimeListBloc, AnimeListState>(
        builder: (context, state) {
          if (state is AnimeListLoading && state is! AnimeListLoaded) {
            return LoadingIndicator();
          } else if (state is AnimeListLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.animeList.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= state.animeList.length) {
                  return BottomLoader();
                }
                return AnimeListCard(anime: state.animeList[index]);
              },
            );
          } else if (state is AnimeListError) {
            return ErrorMessage(message: state.message);
          }
          return _buildInitialMessage();
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Top Anime',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.blueGrey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildInitialMessage() {
    return Center(
      child: Text(
        'Press the button to fetch data',
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
