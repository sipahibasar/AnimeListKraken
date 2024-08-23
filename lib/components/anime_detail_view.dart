import 'package:flutter/material.dart';
import 'package:newkrakenanimelist/helpers/test_helper.dart';
import '../features/anime_list/data/models/anime_detail_model.dart';
import '../features/anime_list/data/models/character_model.dart';
import 'anime_image.dart';

class AnimeDetailView extends StatelessWidget {
  final AnimeDetailModel animeDetail;

  const AnimeDetailView({Key? key, required this.animeDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Building AnimeDetailView for: ${animeDetail.title}, Image URL: ${animeDetail.imageUrl}");

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: AnimeImage(imageUrl: animeDetail.imageUrl, malId: animeDetail.malId),
          ),
          SizedBox(height: 16.0),
          Text(
            animeDetail.title,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 24.0),
              SizedBox(width: 4.0),
              Text(
                'Score: ${animeDetail.score}',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text('Episodes: ${animeDetail.episodes}'),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            children: animeDetail.genres
                .map((genre) => Chip(label: Text(genre.name)))
                .toList(),
          ),
          SizedBox(height: 16.0),
          Text(
            'Synopsis',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(animeDetail.synopsis),
          SizedBox(height: 16.0),
          Text(
            'Characters',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          _buildCharacterList(animeDetail.characters),
        ],
      ),
    );
  }

  Widget _buildCharacterList(List<CharacterModel> characters) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return ListTile(
          leading: isTest? Placeholder( fallbackWidth: 50, fallbackHeight: 50): Image.network(character.imageUrl, width: 50, height: 50),
          title: Text(character.name),
        );
      },
    );
  }
}
