import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:newkrakenanimelist/features/anime_list/presantation/bloc/anime_list/anime_list_bloc.dart';
import 'package:newkrakenanimelist/features/anime_list/presantation/bloc/anime_list/anime_list_event.dart';
import 'package:newkrakenanimelist/features/anime_list/presantation/bloc/anime_list/anime_list_state.dart';
import 'package:newkrakenanimelist/features/anime_list/presantation/pages/anime_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_model.dart';

// Mock classes
class MockAnimeListBloc extends MockBloc<AnimeListEvent, AnimeListState>
    implements AnimeListBloc {}

class FakeAnimeListEvent extends Fake implements AnimeListEvent {}

class FakeAnimeListState extends Fake implements AnimeListState {}

void main() {
  late MockAnimeListBloc mockAnimeListBloc;

  setUpAll(() {
    registerFallbackValue(FakeAnimeListEvent());
    registerFallbackValue(FakeAnimeListState());
  });

  setUp(() {
    mockAnimeListBloc = MockAnimeListBloc();
  });

  tearDown(() {
    HttpOverrides.global = null; // Reset after tests
  });

  testWidgets('displays loading indicator when state is AnimeListLoading',
          (WidgetTester tester) async {
        when(() => mockAnimeListBloc.state).thenReturn(AnimeListLoading());

        await tester.pumpWidget(
          BlocProvider<AnimeListBloc>.value(
            value: mockAnimeListBloc,
            child: MaterialApp(
              home: AnimeListPage(),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

  testWidgets('displays anime list when state is AnimeListLoaded',
          (WidgetTester tester) async {
        final animeList = [
          AnimeModel(
            malId: 1,
            title: 'Anime 1',
            imageUrl: 'https://image.url/anime1.jpg',
            score: 8.5,
          ),
          AnimeModel(
            malId: 2,
            title: 'Anime 2',
            imageUrl: 'https://image.url/anime2.jpg',
            score: 8.0,
          ),
        ];

        when(() => mockAnimeListBloc.state).thenReturn(AnimeListLoaded(
          animeList: animeList,
          hasMore: false,
        ));

        await tester.pumpWidget(
          BlocProvider<AnimeListBloc>.value(
            value: mockAnimeListBloc,
            child: MaterialApp(
              home: AnimeListPage(),
            ),
          ),
        );

        await tester.pumpAndSettle(); // Wait for images to load

        expect(find.text('Anime 1'), findsOneWidget);
        expect(find.text('Anime 2'), findsOneWidget);
      });

  testWidgets('displays error message when state is AnimeListError',
          (WidgetTester tester) async {
        when(() => mockAnimeListBloc.state)
            .thenReturn(const AnimeListError('An error occurred'));

        await tester.pumpWidget(
          BlocProvider<AnimeListBloc>.value(
            value: mockAnimeListBloc,
            child: MaterialApp(
              home: AnimeListPage(),
            ),
          ),
        );

        expect(find.text('An error occurred'), findsOneWidget);
      });}
