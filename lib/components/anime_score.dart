import 'package:flutter/material.dart';

class AnimeScore extends StatelessWidget {
  final double score;

  const AnimeScore({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 20.0),
        SizedBox(width: 4.0),
        Text(
          score.toString(),
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
