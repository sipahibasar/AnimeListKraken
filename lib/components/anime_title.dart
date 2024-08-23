import 'package:flutter/material.dart';

class AnimeTitle extends StatelessWidget {
  final String title;

  const AnimeTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
