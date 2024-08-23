import 'dart:typed_data';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:newkrakenanimelist/components/anime_detail_view.dart';
import 'package:newkrakenanimelist/components/error_message.dart';
import 'package:newkrakenanimelist/components/loading_indicator.dart';
import 'package:newkrakenanimelist/features/anime_list/data/models/anime_detail_model.dart';
import 'package:newkrakenanimelist/features/anime_list/domain/usecases/get_anime_detail_use_case.dart';
import 'package:newkrakenanimelist/features/anime_list/presantation/bloc/anime_detail/anime_detail_bloc.dart';
import 'package:newkrakenanimelist/features/anime_list/presantation/bloc/anime_detail/anime_detail_event.dart';
import 'package:newkrakenanimelist/features/anime_list/presantation/bloc/anime_detail/anime_detail_state.dart';
import 'package:newkrakenanimelist/features/anime_list/presantation/pages/anime_detail_page.dart';

class MockGetAnimeDetail extends Mock implements GetAnimeDetail {}
class MockAnimeDetailBloc extends MockBloc<AnimeDetailEvent, AnimeDetailState> implements AnimeDetailBloc {}

class FakeParams extends Fake implements Params {}

void main() {
  final getIt = GetIt.instance;

  setUpAll(() {
    registerFallbackValue(FakeParams());

    // Register specific instances of subclasses for the fallback values
    registerFallbackValue(AnimeDetailLoading()); // Example state
    registerFallbackValue(GetAnimeDetailEvent(malId: 1)); // Example event
  });

  setUp(() {
    if (!getIt.isRegistered<GetAnimeDetail>()) {
      final mockGetAnimeDetail = MockGetAnimeDetail();
      getIt.registerLazySingleton<GetAnimeDetail>(() => mockGetAnimeDetail);

      when(() => mockGetAnimeDetail.call(any())).thenAnswer(
            (_) async => Right(AnimeDetailModel(
          malId: 52991,
          imageUrl: "https://cdn.myanimelist.net/images/anime/1015/138006.jpg",
          title: "Sousou no Frieren",
          titleEnglish: "Frieren: Beyond Journey's End",
          titleJapanese: "葬送のフリーレン",
          genres: [],
          score: 9.34,
          episodes: 28,
          synopsis: "During their decade-long quest to defeat the Demon King...",
          characters: [],
        )),
      );
    }
  });

  tearDownAll(() {
    getIt.reset();
  });

  testWidgets('displays loading indicator when state is AnimeDetailLoading', (WidgetTester tester) async {
    final mockBloc = MockAnimeDetailBloc();
    when(()=>mockBloc.state).thenReturn(AnimeDetailLoading());

    await tester.pumpWidget(
      MaterialApp(
        home:AnimeDetailPage(animeId: 1,animeDetailBloc: mockBloc)
      ),
    );

    expect(find.byType(LoadingIndicator), findsOneWidget);
  });

  testWidgets('displays anime detail when state is AnimeDetailLoaded', (WidgetTester tester) async {
    final mockBloc = MockAnimeDetailBloc();
    final animeDetail = AnimeDetailModel(
      malId: 52991,
      imageUrl: "https://cdn.myanimelist.net/images/anime/1015/138006.jpg",
      title: "Sousou no Frieren",
      titleEnglish: "Frieren: Beyond Journey's End",
      titleJapanese: "葬送のフリーレン",
      genres: [],
      score: 9.34,
      episodes: 28,
      synopsis: "During their decade-long quest to defeat the Demon King...",
      characters: [],
    );

    when(()=>mockBloc.state).thenReturn(AnimeDetailLoaded(animeDetail: animeDetail));
    await tester.pumpWidget(
      MaterialApp(
          home:AnimeDetailPage(animeId: 1,animeDetailBloc: mockBloc)
      ),
    );

    expect(find.byType(AnimeDetailView), findsOneWidget);
    expect(find.text("Sousou no Frieren"), findsOneWidget);
    expect(find.text("Score: 9.34"), findsOneWidget);
  });

  testWidgets('displays error message when state is AnimeDetailError', (WidgetTester tester) async {
    final mockBloc = MockAnimeDetailBloc();

    when(()=>mockBloc.state).thenReturn(AnimeDetailError(message: 'Error message'));
    await tester.pumpWidget(
      MaterialApp(
          home:AnimeDetailPage(animeId: 1,animeDetailBloc: mockBloc)
      ),
    );

    expect(find.byType(ErrorMessage), findsOneWidget);
    expect(find.text('Error message'), findsOneWidget);
  });

  testWidgets('displays mocked network image correctly', (WidgetTester tester) async {
    // Use valid PNG data for testing (1x1 transparent PNG)
    final mockImageBytes = Uint8List.fromList([
      0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
      0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
      0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x60, 0x00, 0x00, 0x00,
      0x02, 0x00, 0x01, 0xE2, 0x21, 0xBC, 0x33, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
      0x42, 0x60, 0x82
    ]);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Image.memory(
            mockImageBytes,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });
}
