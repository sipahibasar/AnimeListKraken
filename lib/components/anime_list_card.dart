import 'package:flutter/material.dart';

import '../features/anime_list/data/models/anime_model.dart';
import '../features/anime_list/presantation/pages/anime_detail_page.dart';
import '../helpers/test_helper.dart';

class AnimeListCard extends StatelessWidget {
  final AnimeModel anime;

  const AnimeListCard({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimeDetailPage(animeId: anime.malId),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              _buildAnimeImage(),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAnimeTitle(),
                    SizedBox(height: 8.0),
                    _buildAnimeScore(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimeImage() {
    return SizedBox(
      width: 100,
      height: 150,
      child: Hero(
        tag: 'animeImage-${anime.malId}',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: isTest? Placeholder( fallbackWidth: 50, fallbackHeight: 50):Image.network(
            anime.imageUrl,
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimeTitle() {
    return Text(
      anime.title,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildAnimeScore() {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 20.0),
        SizedBox(width: 4.0),
        Text(
          anime.score.toString(),
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
