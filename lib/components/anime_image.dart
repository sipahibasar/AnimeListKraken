import 'package:flutter/material.dart';

import '../helpers/test_helper.dart';

class AnimeImage extends StatelessWidget {
  final String imageUrl;
  final int malId;

  const AnimeImage({Key? key, required this.imageUrl, required this.malId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 150,
      child: Hero(
        tag: 'animeImage-$malId',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: isTest? Placeholder( fallbackWidth: 50, fallbackHeight: 50):Image.network(
            imageUrl,
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
