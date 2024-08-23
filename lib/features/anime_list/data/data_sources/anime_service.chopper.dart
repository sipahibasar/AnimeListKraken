// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AnimeService extends AnimeService {
  _$AnimeService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AnimeService;

  @override
  Future<Response<dynamic>> fetchTopAnime({
    int? page,
    int? limit,
  }) {
    final Uri $url = Uri.parse('/top/anime');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> fetchAnimeDetail(int malId) {
    final Uri $url = Uri.parse('/anime/${malId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> fetchAnimeCharacters(int malId) {
    final Uri $url = Uri.parse('/anime/${malId}/characters');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
