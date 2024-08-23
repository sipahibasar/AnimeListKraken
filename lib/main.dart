import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'features/anime_list/presantation/pages/anime_list_page.dart';
import 'features/anime_list/presantation/bloc/anime_list/anime_list_bloc.dart';
import 'features/anime_list/presantation/bloc/anime_detail/anime_detail_bloc.dart';
import 'init.dart';
import 'package:flutter_driver/driver_extension.dart';
void main() {
  enableFlutterDriverExtension();
  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.instance<AnimeListBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.instance<AnimeDetailBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Anime List',
        home: AnimeListPage(),
      ),
    );
  }
}
